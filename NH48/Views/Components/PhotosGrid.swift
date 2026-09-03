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
