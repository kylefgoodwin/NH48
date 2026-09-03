import SwiftUI
import PhotosUI

struct PhotosGrid: View {
    @Binding var mountain: Mountain
    @State private var selectedPhotoItems: [PhotosPickerItem] = []

    var body: some View {
        PhotosPicker(selection: $selectedPhotoItems, maxSelectionCount: 10, matching: .images) {
            Label("Add Photos", systemImage: "photo.on.rectangle")
        }
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
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80), spacing: 8)], spacing: 8) {
                ForEach(mountain.photoFileNames, id: \.self) { filename in
                    PhotoThumbnail(filename: filename, mountain: $mountain)
                }
            }
        }
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
                    .frame(width: 80, height: 80)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            Button {
                if let idx = mountain.photoFileNames.firstIndex(of: filename) {
                    mountain.photoFileNames.remove(at: idx)
                    ImageStore.deleteImage(named: filename)
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.white)
                    .background(Circle().fill(Color.black.opacity(0.6)))
            }
            .buttonStyle(.plain)
            .offset(x: 4, y: -4)
        }
    }
}
