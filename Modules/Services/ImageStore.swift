import Foundation
import UIKit

struct ImageStore {
    static func saveJPEG(_ image: UIImage, quality: CGFloat = 0.8, preferredName: String? = nil) -> String? {
        guard let data = image.jpegData(compressionQuality: quality) else { return nil }
        
        let filename = preferredName ?? UUID().uuidString
        let fileURL = getDocumentsDirectory().appendingPathComponent("\(filename).jpg")
        
        do {
            try data.write(to: fileURL)
            return "\(filename).jpg"
        } catch {
            print("Failed to save image: \(error)")
            return nil
        }
    }
    
    static func loadImage(named filename: String) -> UIImage? {
        let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        }
        return nil
    }
    
    static func deleteImage(named filename: String) {
        let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
        try? FileManager.default.removeItem(at: fileURL)
    }
    
    private static func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
