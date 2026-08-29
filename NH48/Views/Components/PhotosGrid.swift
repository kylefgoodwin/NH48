import SwiftUI
import PhotosUI

struct PhotosGrid: View {
    @Binding var mountain: Mountain
    @State private var selectedPhotoItems: [PhotosPickerItem] = []

    var body: some View {
        Section(header: Text("Photos").font(.footnote).foregroundColor(.secondary)) {
            PhotosPicker(selection: $selectedPhotoItems, maxSelectionCount: 10, matching: .images) {
                Label("Add Photos", systemImage: "photo.on.rectangle")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.small)
            .onChange(of: selectedPhotoItems) { _, newItems in
                Task {
                    for item in newItems {
                        if let data = try? await item.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data),
                           let filename = ImageStore.saveJPEG(uiImage) {
                            mountain.photoFileNames.append(filename)
                        }
                    }
                    selectedPhotoItems.removeAll()
                }
            }

            if !mountain.photoFileNames.isEmpty {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 90), spacing: 12)], spacing: 12) {
                    ForEach(mountain.photoFileNames, id: \.self) { filename in
                        PhotoThumbnail(filename: filename, mountain: $mountain)
                    }
                }
                .padding(.top, 6)
            } else {
                Text("No photos yet")
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 8)
            }
        }
        .sectionCardStyle()
    }
}

struct PhotoThumbnail: View {
    let filename: String
    @Binding var mountain: Mountain

    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let image = ImageStore.loadImage(named: filename) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 90)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(.secondarySystemBackground))
                        .frame(width: 90, height: 90)
                    Image(systemName: "photo")
                        .foregroundStyle(.secondary)
                }
            }
            Button {
                if let idx = mountain.photoFileNames.firstIndex(of: filename) {
                    mountain.photoFileNames.remove(at: idx)
                    ImageStore.deleteImage(named: filename)
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Circle().fill(Color.black.opacity(0.6)))
            }
            .buttonStyle(.plain)
            .contentShape(Circle())
            .offset(x: -6, y: 6)
        }
    }
}
