import SwiftUI

struct MountainsList: View {
    let filteredMountains: [Mountain]
    @ObservedObject var store: MountainStore
    
    var body: some View {
        VStack(spacing: 12) {
            Capsule()
                .fill(Color.white.opacity(0.35))
                .frame(width: 36, height: 4)
                .padding(.top, 10)
            
            HStack {
                Text("Mountains")
                    .font(.headline)
                    .foregroundStyle(.primary)
                Spacer()
                Text("\(filteredMountains.count) \(filteredMountains.count == 1 ? "result" : "results")")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 8)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 12)], spacing: 12) {
                if filteredMountains.isEmpty {
                    VStack(spacing: 6) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.secondary)
                        Text("No mountains match your filters")
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                    .gridCellColumns(2)
                } else {
                    ForEach(filteredMountains) { mountain in
                        NavigationLink(value: mountain) {
                            MountainCardView(mountain: mountain) {
                                store.toggleCompletion(for: mountain)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .contextMenu {
                            MountainContextMenu(mountain: mountain, store: store)
                        }
                    }
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 12)
        }
        .navigationDestination(for: Mountain.self) { mountain in
            MountainDetailView(mountain: mountain) { updatedMountain in
                store.updateMountain(updatedMountain)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.thinMaterial)
        )
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            LinearGradient(
                colors: [Color.black.opacity(0.06), Color.black.opacity(0.0)],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 12),
            alignment: .top
        )
        .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: -2)
        .padding(.horizontal, 12)
        .padding(.top, -8)
    }
}
