//
//  ImageStore.swift
//  NH48
//
//  Created by Kyle Goodwin on 1/14/26.
//

import Foundation
import SwiftUI

struct ImageStore {
    static var documentsURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    @discardableResult
    static func saveJPEG(_ image: UIImage, quality: CGFloat = 0.9, preferredName: String = UUID().uuidString) -> String? {
        guard let data = image.jpegData(compressionQuality: quality) else { return nil }
        let filename = preferredName + ".jpg"
        let url = documentsURL.appendingPathComponent(filename)
        do {
            try data.write(to: url, options: .atomic)
            return filename
        } catch {
            print("ImageStore save error: \(error)")
            return nil
        }
    }

    static func loadImage(named filename: String) -> UIImage? {
        let url = documentsURL.appendingPathComponent(filename)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }

    static func deleteImage(named filename: String) {
        let url = documentsURL.appendingPathComponent(filename)
        try? FileManager.default.removeItem(at: url)
    }
}
