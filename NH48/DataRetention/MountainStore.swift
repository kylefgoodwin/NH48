//
//  MountainStore.swift
//  NH48
//
//  Created by Kyle Goodwin on 8/5/25.
//


import Foundation
import SwiftUI
import UIKit

class MountainStore: ObservableObject {
    @Published var mountains: [Mountain] = []
    
    init() {
        loadData()
        assignAssetImagesIfAvailable()
    }

    func updateMountain(_ updated: Mountain) {
        if let index = mountains.firstIndex(where: { $0.id == updated.id }) {
            mountains[index] = updated
            saveData()
        }
    }
    
    private func assignAssetImagesIfAvailable() {
        var changed = false
        for idx in mountains.indices {
            let m = mountains[idx]

            // 1) If an explicit image exists and is valid (documents or assets), keep it
            if let explicit = m.image {
                if ImageStore.loadImage(named: explicit) != nil || UIImage(named: explicit) != nil {
                    continue
                }
            }

            // 2) Try to find an asset image by mountain name or range
            if let name = assetImageName(for: m) {
                if m.image != name {
                    mountains[idx].image = name
                    changed = true
                    continue
                }
            }

            // 3) Fallback to a user photo if available
            if let firstPhoto = m.photoFileNames.first, ImageStore.loadImage(named: firstPhoto) != nil {
                if m.image != firstPhoto {
                    mountains[idx].image = firstPhoto
                    changed = true
                }
            }
        }
        if changed { saveData() }
    }

    private func assetImageName(for mountain: Mountain) -> String? {
        func cleaned(_ s: String) -> String {
            let allowed = s.unicodeScalars.filter { CharacterSet.alphanumerics.union(.whitespaces).contains($0) }
            return String(String.UnicodeScalarView(allowed)).trimmingCharacters(in: .whitespaces)
        }

        func removeMountWords(_ s: String) -> String {
            s
                .replacingOccurrences(of: "mountain", with: "", options: .caseInsensitive)
                .replacingOccurrences(of: "mount", with: "", options: .caseInsensitive)
                .replacingOccurrences(of: "mt", with: "", options: .caseInsensitive)
                .replacingOccurrences(of: "  ", with: " ")
                .trimmingCharacters(in: .whitespaces)
        }

        func variants(for base: String) -> [String] {
            var forms: [String] = []
            let bases = [base, removeMountWords(base)].filter { !$0.isEmpty }
            for b in bases {
                // raw forms
                forms.append(b)
                forms.append(b.replacingOccurrences(of: " ", with: "_"))
                forms.append(b.replacingOccurrences(of: " ", with: "-"))
                forms.append(b.replacingOccurrences(of: " ", with: ""))

                // prefixes
                let withMount = "mount " + b
                forms.append(withMount)
                forms.append(withMount.replacingOccurrences(of: " ", with: "_"))
                forms.append(withMount.replacingOccurrences(of: " ", with: "-"))
                forms.append(withMount.replacingOccurrences(of: " ", with: ""))

                let withMt = "mt " + b
                forms.append(withMt)
                forms.append(withMt.replacingOccurrences(of: " ", with: "_"))
                forms.append(withMt.replacingOccurrences(of: " ", with: "-"))
                forms.append(withMt.replacingOccurrences(of: " ", with: ""))

                // suffix
                let withMountain = b + " mountain"
                forms.append(withMountain)
                forms.append(withMountain.replacingOccurrences(of: " ", with: "_"))
                forms.append(withMountain.replacingOccurrences(of: " ", with: "-"))
                forms.append(withMountain.replacingOccurrences(of: " ", with: ""))
            }
            return Array(Set(forms))
        }

        func tryCandidates(_ candidates: [String]) -> String? {
            for c in candidates {
                // Try multiple casings
                let tries = [c, c.lowercased(), c.capitalized]
                for t in tries {
                    if UIImage(named: t) != nil { return t }
                }
            }
            return nil
        }

        // 1) Try by mountain name
        let originalName = cleaned(mountain.name)
        if let foundByName = tryCandidates(variants(for: originalName)) {
            return foundByName
        }

        // 2) Try by range/location
        let originalRange = cleaned(mountain.location)
        if let foundByRange = tryCandidates(variants(for: originalRange)) {
            return foundByRange
        }

        return nil
    }

    @MainActor
    func fetchMissingImagesFromWeb() async {
        var changed = false

        func cleaned(_ s: String) -> String {
            let allowed = s.unicodeScalars.filter { CharacterSet.alphanumerics.union(.whitespaces).contains($0) }
            return String(String.UnicodeScalarView(allowed)).trimmingCharacters(in: .whitespaces)
        }
        func removeMountWords(_ s: String) -> String {
            s
                .replacingOccurrences(of: "mountain", with: "", options: .caseInsensitive)
                .replacingOccurrences(of: "mount", with: "", options: .caseInsensitive)
                .replacingOccurrences(of: "mt.", with: "", options: .caseInsensitive)
                .replacingOccurrences(of: "mt", with: "", options: .caseInsensitive)
                .replacingOccurrences(of: "  ", with: " ")
                .trimmingCharacters(in: .whitespaces)
        }
        func titleCandidates(for mountain: Mountain) -> [String] {
            let name = cleaned(mountain.name)
            let core = removeMountWords(name)
            var titles: [String] = []
            titles.append(name)
            if !core.isEmpty {
                titles.append("Mount \(core)")
                titles.append("\(core) (mountain)")
            }
            // New Hampshire-specific disambiguation often helps
            titles.append("\(name) (New Hampshire)")
            if !core.isEmpty {
                titles.append("\(core) (New Hampshire)")
            }
            return Array(Set(titles))
        }
        func slug(_ s: String) -> String {
            let lower = s.lowercased()
            let allowed = lower.unicodeScalars.filter { CharacterSet.alphanumerics.union(.whitespaces).contains($0) }
            let cleaned = String(String.UnicodeScalarView(allowed)).trimmingCharacters(in: .whitespaces)
            return cleaned.replacingOccurrences(of: " ", with: "_")
        }

        for idx in mountains.indices {
            let m = mountains[idx]

            // If current image is valid (document or asset), skip
            if let explicit = m.image {
                if ImageStore.loadImage(named: explicit) != nil || UIImage(named: explicit) != nil {
                    continue
                }
            }

            // Try Wikimedia search with several title candidates
            var foundImage: UIImage? = nil
            var preferredName: String = slug(m.name)
            for title in titleCandidates(for: m) {
                do {
                    if let url = try await WikimediaImageFetcher.fetchImageURL(for: title) {
                        let (data, _) = try await URLSession.shared.data(from: url)
                        if let uiImage = UIImage(data: data) {
                            foundImage = uiImage
                            // Prefer a stable filename based on the mountain
                            preferredName = slug(m.name)
                            break
                        }
                    }
                } catch {
                    // Try next candidate on error
                    continue
                }
            }

            // Fallback: use Wikipedia search to resolve best title and try again
            if foundImage == nil {
                do {
                    if let bestTitle = try await WikimediaImageFetcher.searchBestTitle(for: m.name) {
                        if let url = try await WikimediaImageFetcher.fetchImageURL(for: bestTitle) {
                            let (data, _) = try await URLSession.shared.data(from: url)
                            if let uiImage = UIImage(data: data) {
                                foundImage = uiImage
                                preferredName = slug(m.name)
                            }
                        }
                    }
                } catch {
                    // Ignore and leave foundImage as nil
                }
            }

            // Final fallback: try Wikipedia GeoSearch near coordinates
            if foundImage == nil, let lat = m.latitude, let lon = m.longitude {
                do {
                    if let nearbyTitle = try await WikimediaImageFetcher.searchNearbyTitle(lat: lat, lon: lon) {
                        if let url = try await WikimediaImageFetcher.fetchImageURL(for: nearbyTitle) {
                            let (data, _) = try await URLSession.shared.data(from: url)
                            if let uiImage = UIImage(data: data) {
                                foundImage = uiImage
                                preferredName = slug(m.name)
                            }
                        }
                    }
                } catch {
                    // Ignore and leave foundImage as nil
                }
            }

            if let image = foundImage {
                if let filename = ImageStore.saveJPEG(image, quality: 0.9, preferredName: preferredName) {
                    mountains[idx].image = filename
                    changed = true
                }
            }
        }

        if changed {
            saveData()
        }
    }
}

