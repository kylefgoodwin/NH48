import Foundation

struct Mountain: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    var name: String
    var elevation: Int
    var location: String
    var description: String?
    var latitude: Double?
    var longitude: Double?
    var isCompleted: Bool
    var image: String?

    var personalNotes: String?
    var completionDate: Date?
    var rating: Int?
    var difficulty: Int?
    var conditions: [String]?
    var distanceMiles: Double?
    var elevationGain: Int?
    var durationMinutes: Int?
    var tags: [String] = []
    var photoFileNames: [String] = []
}
