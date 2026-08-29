import Foundation
import SwiftUI

struct Mountain: Identifiable, Codable {
    var id = UUID()
    var name: String
    var elevation: Int
    var location: String
    var latitude: Double?
    var longitude: Double?
    var isCompleted: Bool = false
    var completionDate: Date?
    var rating: Int?
    var difficulty: Int?
    var distanceMiles: Double?
    var elevationGain: Int?
    var durationMinutes: Int?
    var personalNotes: String?
    var conditions: [String]?
    var tags: [String] = []
    var image: String? = nil
    var photoFileNames: [String] = []
}
