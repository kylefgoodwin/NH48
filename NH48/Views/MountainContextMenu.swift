import SwiftUI

struct MountainContextMenu: View {
    let mountain: Mountain
    @ObservedObject var store: MountainStore
    
    var body: some View {
        Button {
            store.toggleCompletion(for: mountain)
        } label: {
            Label(
                mountain.isCompleted ? "Mark as Uncompleted" : "Mark as Completed",
                systemImage: mountain.isCompleted ? "circle" : "checkmark.circle"
            )
        }
        
        Button(role: .destructive) {
            store.delete(mountain)
        } label: {
            Label("Delete Mountain", systemImage: "trash")
        }
    }
}
