import SwiftUI

struct MountainDetailView: View {
    var mountain: Mountain
    var onUpdate: (Mountain) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var editableMountain: Mountain
    @State private var selectedSegment: Segment = .info

    private enum Segment: String, CaseIterable, Identifiable {
        case info = "Info"
        case tracker = "Tracker"
        var id: String { rawValue }
    }

    init(mountain: Mountain, onUpdate: @escaping (Mountain) -> Void) {
        self.mountain = mountain
        self.onUpdate = onUpdate
        _editableMountain = State(initialValue: mountain)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                MountainDetailHeaderView(mountain: $editableMountain)

                // Segment Picker
                Picker("Section", selection: $selectedSegment) {
                    ForEach(Segment.allCases) { seg in
                        Text(seg.rawValue).tag(seg)
                    }
                }
                .pickerStyle(.segmented)

                // Subcontent Layout using custom section card styles
                switch selectedSegment {
                case .info:
                    MountainInfoView(mountain: $editableMountain)
                        .transition(.opacity.combined(with: .move(edge: .leading)))
                case .tracker:
                    MountainTrackerView(mountain: $editableMountain)
                        .transition(.opacity.combined(with: .move(edge: .trailing)))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .animation(.snappy, value: selectedSegment)
        .background(DetailBackgroundView())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    onUpdate(editableMountain)
                    dismiss()
                }) {
                    Text("Save").bold()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.small)
            }
        }
    }
}
