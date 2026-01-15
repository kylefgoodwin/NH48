import SwiftUI
import PhotosUI

struct MountainTrackerView: View {
    @Binding var mountain: Mountain
    @State private var selectedPhotoItems: [PhotosPickerItem] = []

    var body: some View {
        List {
            // Trip Log
            Section(header: Text("Trip Log").foregroundColor(.secondary)) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Completion Date").font(.caption).foregroundStyle(.secondary)
                    DatePicker(
                        "",
                        selection: Binding<Date>(unwrapping: $mountain.completionDate, default: Date()),
                        displayedComponents: [.date]
                    )
                    .labelsHidden()
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                    )
                }
                .padding(.vertical, 2)

                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Rating").font(.caption).foregroundStyle(.secondary)
                        HStack {
                            Stepper(value: Binding<Int>(unwrapping: $mountain.rating, default: 3), in: 1...5) {
                                Text("\(Binding<Int>(unwrapping: $mountain.rating, default: 3).wrappedValue)")
                                    .font(.body.monospacedDigit())
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                        )
                    }
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Difficulty").font(.caption).foregroundStyle(.secondary)
                        HStack {
                            Stepper(value: Binding<Int>(unwrapping: $mountain.difficulty, default: 3), in: 1...5) {
                                Text("\(Binding<Int>(unwrapping: $mountain.difficulty, default: 3).wrappedValue)")
                                    .font(.body.monospacedDigit())
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                        )
                    }
                }
            }
            .sectionCardStyle()

            // Hike Stats
            Section(header: Text("Hike Stats").font(.footnote).foregroundColor(.secondary)) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Distance (miles)").font(.caption).foregroundStyle(.secondary)
                    HStack(spacing: 10) {
                        Image(systemName: "ruler").foregroundStyle(.secondary)
                        TextField("Distance (miles)", value: Binding<Double>(unwrapping: $mountain.distanceMiles, default: 0.0), formatter: decimalFormatter)
                            .keyboardType(.decimalPad)
                            .font(.body.monospacedDigit())
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                    )
                }
                .padding(.vertical, 2)
                VStack(alignment: .leading, spacing: 6) {
                    Text("Elevation Gain (ft)").font(.caption).foregroundStyle(.secondary)
                    HStack(spacing: 10) {
                        Image(systemName: "arrow.up").foregroundStyle(.secondary)
                        TextField("Elevation Gain (ft)", value: Binding<Int>(unwrapping: $mountain.elevationGain, default: 0), formatter: integerFormatter)
                            .keyboardType(.numberPad)
                            .font(.body.monospacedDigit())
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                    )
                }
                .padding(.vertical, 2)
                VStack(alignment: .leading, spacing: 6) {
                    Text("Duration (minutes)").font(.caption).foregroundStyle(.secondary)
                    HStack(spacing: 10) {
                        Image(systemName: "clock").foregroundStyle(.secondary)
                        TextField("Duration (minutes)", value: Binding<Int>(unwrapping: $mountain.durationMinutes, default: 0), formatter: integerFormatter)
                            .keyboardType(.numberPad)
                            .font(.body.monospacedDigit())
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                    )
                }
                .padding(.vertical, 2)
            }
            .sectionCardStyle()

            // Notes & Tags
            Section(header: Text("Notes & Tags").font(.footnote).foregroundColor(.secondary)) {
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 8) {
                        Image(systemName: "note.text").foregroundStyle(.secondary)
                        Text("Personal Notes").font(.caption).foregroundStyle(.secondary)
                    }
                    TextEditor(text: Binding<String>(unwrapping: $mountain.personalNotes, default: ""))
                        .frame(minHeight: 100)
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .stroke(Color.primary.opacity(0.08), lineWidth: 1)
                        )
                }
                .padding(.vertical, 2)

                ChipsEditor(title: "Conditions",
                            systemImage: "cloud.sun.rain",
                            items: Binding<[String]>(unwrapping: $mountain.conditions, default: []))
                .padding(.vertical, 2)

                ChipsEditor(title: "Tags",
                            systemImage: "tag",
                            items: $mountain.tags)
                .padding(.vertical, 2)
            }
            .sectionCardStyle()

            // Photos
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
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(
            LinearGradient(colors: [Color(.systemGroupedBackground), Color(.secondarySystemGroupedBackground)], startPoint: .top, endPoint: .bottom)
        )
    }
}

private struct SectionCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .listRowBackground(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(
                        LinearGradient(colors: [Color(.secondarySystemBackground).opacity(0.9), Color(.systemBackground).opacity(0.9)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
            )
    }
}

private extension View {
    func sectionCardStyle() -> some View { modifier(SectionCardStyle()) }
}

private let decimalFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 6
    return formatter
}()

private let integerFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .none
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 0
    return formatter
}()

private struct ChipsEditor: View {
    let title: String
    let systemImage: String
    @Binding var items: [String]
    @State private var input: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                Image(systemName: systemImage).foregroundStyle(.secondary)
                Text(title).font(.caption).foregroundStyle(.secondary)
            }

            // Chips
            if !items.isEmpty {
                FlowLayout(items: items) { item in
                    HStack(spacing: 6) {
                        Text(item)
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.15))
                            .clipShape(Capsule())
                        Button(action: { remove(item) }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.caption)
                                .padding(4)
                                .background(Circle().fill(Color.black.opacity(0.15)))
                        }
                        .buttonStyle(.plain)
                        .contentShape(Circle())
                    }
                    .fixedSize()
                }
                .padding(.bottom, 4)
            }

            HStack(spacing: 8) {
                TextField("Add \(title.lowercased())", text: $input)
                    .textInputAutocapitalization(.words)
                Button(action: add) {
                    Image(systemName: "plus.circle.fill")
                }
                .disabled(input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(Color.primary.opacity(0.08), lineWidth: 1)
            )
        }
    }

    private func add() {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        if !items.contains(trimmed) {
            items.append(trimmed)
        }
        input = ""
    }

    private func remove(_ item: String) {
        if let idx = items.firstIndex(of: item) {
            items.remove(at: idx)
        }
    }
}

// Simple flow layout for chips
private struct FlowLayout<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    let items: Data
    let content: (Data.Element) -> Content

    init(items: Data, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.items = items
        self.content = content
    }

    var body: some View {
        var width: CGFloat = 0
        var height: CGFloat = 0

        return GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(Array(items), id: \.self) { item in
                    content(item)
                        .fixedSize()
                        .padding(4)
                        .alignmentGuide(.leading) { d in
                            if (abs(width - d.width) > geometry.size.width) {
                                width = 0
                                height -= d.height
                            }
                            let result = width
                            if item == items.last { width = 0 } else { width -= d.width }
                            return result
                        }
                        .alignmentGuide(.top) { d in
                            let result = height
                            if item == items.last { height = 0 } else { }
                            return result
                        }
                }
            }
        }
        .frame(minHeight: 0)
        .fixedSize(horizontal: false, vertical: true)
    }
}

// Helper to convert optional bindings to non-optional with a default value
private extension Binding {
    // Case 1: Binding to an optional value (Binding<Value?>)
    init(unwrapping source: Binding<Value?>, default defaultValue: Value) {
        self.init(
            get: { source.wrappedValue ?? defaultValue },
            set: { newValue in
                source.wrappedValue = newValue
            }
        )
    }

    // Case 2: Optional Binding to a non-optional value (Binding<Value>?)
    init(unwrapping source: Binding<Value>?, default defaultValue: Value) {
        self.init(
            get: { source?.wrappedValue ?? defaultValue },
            set: { newValue in
                source?.wrappedValue = newValue
            }
        )
    }

    // Case 3: Non-optional Binding provided; ignore default and forward through
    init(unwrapping source: Binding<Value>, default defaultValue: Value) {
        self = source
    }
}

