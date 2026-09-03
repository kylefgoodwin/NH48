import Foundation

enum MountainFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case completed = "Completed"
    case notCompleted = "Not Completed"
    case range = "Range"
    
    var id: String { rawValue }
}
