//
//  MountainCardView.swift
//  NH48
//
//  Created by Kyle Goodwin on 9/24/25.
//


import SwiftUI

let fallbackGradients: [Gradient] = [
    Gradient(colors: [.blue.opacity(0.7), .green.opacity(0.7)]),
    Gradient(colors: [.purple.opacity(0.7), .pink.opacity(0.7)]),
    Gradient(colors: [.orange.opacity(0.7), .red.opacity(0.7)]),
    Gradient(colors: [.teal.opacity(0.7), .indigo.opacity(0.7)]),
    Gradient(colors: [.gray.opacity(0.7), .black.opacity(0.7)])
]


struct MountainCardView: View {
    var mountain: Mountain
    var onToggleCompleted: () -> Void

    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ZStack {
                if let filename = mountain.image, let docImage = ImageStore.loadImage(named: filename) {
                    Image(uiImage: docImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .clipped()
                } else if let name = assetImageName() {
                    Image(name)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .clipped()
                } else {
                    let gradient = mountain.isCompleted
                        ? Gradient(colors: [.green, .blue])
                        : Gradient(colors: [Color.red.opacity(0.2), Color.red.opacity(0.4)])

                    LinearGradient(
                        gradient: gradient,
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 180)
                    .overlay(
                        Image(systemName: "mountain.2.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.white.opacity(0.9))
                    )
                }
            }
            .cornerRadius(16)

            
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(0.6), .clear]),
                startPoint: .bottom,
                endPoint: .center
            )
            .cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(mountain.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Text("\(mountain.elevation) ft")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding()
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: onToggleCompleted) {
                        Image(systemName: mountain.isCompleted ? "mountain.2.fill" : "mountain.2")
                            .foregroundColor(mountain.isCompleted ? .green : .white)
                            .padding(10)
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                    }
                }
                Spacer()
            }
            .padding()
        }
        .padding(.horizontal)
        .shadow(radius: 4)
    }
    
    private func assetImageName() -> String? {
        // 1) If the explicit image field is set and exists in assets, use it
        if let explicit = mountain.image, UIImage(named: explicit) != nil {
            return explicit
        }

        // 2) Try to derive a likely asset name from the mountain's name
        let raw = mountain.name.lowercased()
        // Keep only letters, numbers, and spaces
        let allowed = raw.unicodeScalars.filter { CharacterSet.alphanumerics.union(.whitespaces).contains($0) }
        let cleaned = String(String.UnicodeScalarView(allowed)).trimmingCharacters(in: .whitespaces)

        // Build base variants by removing common prefixes/suffixes like "mount", "mt", and "mountain"
        var bases: [String] = []
        bases.append(cleaned)

        let removedMount = cleaned
            .replacingOccurrences(of: "mountain", with: "", options: .caseInsensitive)
            .replacingOccurrences(of: "mount", with: "", options: .caseInsensitive)
            .replacingOccurrences(of: "mt", with: "", options: .caseInsensitive)
            .replacingOccurrences(of: "  ", with: " ")
            .trimmingCharacters(in: .whitespaces)
        if !removedMount.isEmpty { bases.append(removedMount) }

        // Generate candidate forms for each base (spaces, underscores, hyphens, removed spaces)
        var candidates: [String] = []
        for base in bases {
            let b = base
            candidates.append(b)
            candidates.append(b.replacingOccurrences(of: " ", with: "_"))
            candidates.append(b.replacingOccurrences(of: " ", with: "-"))
            candidates.append(b.replacingOccurrences(of: " ", with: ""))

            // Also try with common prefixes
            let withMount = "mount " + b
            candidates.append(withMount)
            candidates.append(withMount.replacingOccurrences(of: " ", with: "_"))
            candidates.append(withMount.replacingOccurrences(of: " ", with: "-"))
            candidates.append(withMount.replacingOccurrences(of: " ", with: ""))

            let withMt = "mt " + b
            candidates.append(withMt)
            candidates.append(withMt.replacingOccurrences(of: " ", with: "_"))
            candidates.append(withMt.replacingOccurrences(of: " ", with: "-"))
            candidates.append(withMt.replacingOccurrences(of: " ", with: ""))

            // And with a common suffix
            let withMountain = b + " mountain"
            candidates.append(withMountain)
            candidates.append(withMountain.replacingOccurrences(of: " ", with: "_"))
            candidates.append(withMountain.replacingOccurrences(of: " ", with: "-"))
            candidates.append(withMountain.replacingOccurrences(of: " ", with: ""))
        }

        // Deduplicate and check which candidate actually exists in the asset catalog
        var seen = Set<String>()
        for candidate in candidates {
            let c = candidate.lowercased()
            if seen.insert(c).inserted {
                if UIImage(named: c) != nil { return c }
            }
        }
        return nil
    }
}


extension Image {
    init(mountainImageName: String?, fallback: String = "mountain.fallback") {
        if let name = mountainImageName, UIImage(named: name) != nil {
            self.init(name) // image exists in assets
        } else {
            self.init(systemName: fallback) // fallback to SF Symbol
        }
    }
}

