import Foundation

enum SortOption: String, CaseIterable, Identifiable {
    case elevationDescending = "Elevation ↓"
    case elevationAscending = "Elevation ↑"
    case name = "Name"
    case completedFirst = "Completed"
    
    var id: String { rawValue }
}
