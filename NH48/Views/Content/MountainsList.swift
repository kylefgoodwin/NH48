import SwiftUI
import MapKit

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
            
            LazyVStack(spacing: 12) {
                if filteredMountains.isEmpty {
                    VStack(spacing: 6) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.secondary)
                        Text("No mountains match your filters")
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                }
                
                ForEach(filteredMountains) { mountain in
                    NavigationLink(value: mountain) {
                        MountainCardView(mountain: mountain) {
                            if let index = store.mountains.firstIndex(where: { $0.id == mountain.id }) {
                                store.mountains[index].isCompleted.toggle()
                                store.saveData()
                            }
                        }
                        .padding(.horizontal, 4)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .contextMenu {
                        MountainContextMenu(mountain: mountain, store: store)
                    }
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 12)
        }
        .navigationDestination(for: Mountain.self) { mountain in
            MountainDetailView(mountain: mountain) { updatedMountain in
                if let index = store.mountains.firstIndex(where: { $0.id == updatedMountain.id }) {
                    store.mountains[index] = updatedMountain
                    store.saveData()
                }
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

struct MountainContextMenu: View {
    let mountain: Mountain
    let store: MountainStore
    
    var body: some View {
        Button {
            if let index = store.mountains.firstIndex(where: { $0.id == mountain.id }) {
                store.mountains[index].isCompleted.toggle()
                if !store.mountains[index].isCompleted {
                    store.mountains[index].completionDate = nil
                }
                store.saveData()
            }
        } label: {
            Label(mountain.isCompleted ? "Mark as Not Completed" : "Mark as Completed",
                  systemImage: mountain.isCompleted ? "xmark.circle" : "checkmark.circle")
        }
        
        Button {
            if let index = store.mountains.firstIndex(where: { $0.id == mountain.id }) {
                store.mountains[index].isCompleted = true
                store.mountains[index].completionDate = Date()
                store.saveData()
            }
        } label: {
            Label("Mark Completed Today", systemImage: "calendar.badge.checkmark")
        }
        
        if let lat = mountain.latitude, let lon = mountain.longitude {
            Button {
                let coord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                let placemark = MKPlacemark(coordinate: coord)
                let item = MKMapItem(placemark: placemark)
                item.name = mountain.name
                item.openInMaps()
            } label: {
                Label("Open in Maps", systemImage: "map")
            }
        }
        
        Button(role: .destructive) {
            if let index = store.mountains.firstIndex(where: { $0.id == mountain.id }) {
                store.mountains.remove(at: index)
                store.saveData()
            }
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
}
