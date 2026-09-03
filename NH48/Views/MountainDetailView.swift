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
            VStack(spacing: 20) {
                // Beautiful Header Card
                MountainDetailHeaderView(mountain: editableMountain)

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
            .padding(.vertical, 20)
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

// MARK: - Detail Header
struct MountainDetailHeaderView: View {
    let mountain: Mountain

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text(mountain.location.uppercased())
                    .font(.caption.bold())
                    .tracking(1.5)
                    .foregroundColor(.secondary)

                Spacer()

                HStack(spacing: 5) {
                    Image(systemName: mountain.isCompleted ? "checkmark.circle.fill" : "circle.dashed")
                        .font(.caption.weight(.bold))
                    Text(mountain.isCompleted ? "Completed" : "To Do")
                        .font(.caption.weight(.semibold))
                }
                .foregroundColor(mountain.isCompleted ? Color(red: 0.15, green: 0.68, blue: 0.38) : .orange)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .fill(mountain.isCompleted ? Color.green.opacity(0.15) : Color.orange.opacity(0.15))
                )
            }

            HStack(alignment: .firstTextBaseline, spacing: 10) {
                Text(mountain.name)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)

                if mountain.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.green)
                }
            }

            HStack(spacing: 12) {
                HeroStatBadge(
                    icon: "mountain.2.fill",
                    title: "Elevation",
                    value: "\(mountain.elevation) ft",
                    color: .blue
                )

                HeroStatBadge(
                    icon: "map.fill",
                    title: "Range",
                    value: mountain.location,
                    color: .purple
                )

                if let date = mountain.completionDate {
                    HeroStatBadge(
                        icon: "calendar",
                        title: "Summited",
                        value: date.formatted(date: .abbreviated, time: .omitted),
                        color: .green
                    )
                }
            }
            .padding(.top, 4)
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(
                            LinearGradient(
                                colors: [.white.opacity(0.4), .clear],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 4)
        )
    }
}

// MARK: - Hero Badge Component
struct HeroStatBadge: View {
    let icon: String
    let title: String
    let value: String
    let color: Color

    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 32, height: 32)
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(color)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .lineLimit(1)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.primary.opacity(0.03))
        )
    }
}

// MARK: - Radial Detail Background
struct DetailBackgroundView: View {
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            GeometryReader { geo in
                Circle()
                    .fill(Color.blue.opacity(0.12))
                    .blur(radius: 70)
                    .frame(width: geo.size.width * 0.8)
                    .offset(x: -geo.size.width * 0.2, y: -100)

                Circle()
                    .fill(Color.purple.opacity(0.09))
                    .blur(radius: 80)
                    .frame(width: geo.size.width * 0.7)
                    .offset(x: geo.size.width * 0.3, y: geo.size.height * 0.4)
            }
            .ignoresSafeArea()
        }
    }
}
