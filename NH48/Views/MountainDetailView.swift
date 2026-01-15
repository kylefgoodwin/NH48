//
//  MountainDetailView.swift
//  NH48
//
//  Created by Kyle Goodwin on 8/3/25.
//

// MountainDetailView.swift
import SwiftUI
import MapKit
import PhotosUI

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

    // Tracker UI state
    @State private var selectedPhotoItems: [PhotosPickerItem] = []
    @State private var conditionsInput: String = ""
    @State private var tagsInput: String = ""

    init(mountain: Mountain, onUpdate: @escaping (Mountain) -> Void) {
        self.mountain = mountain
        self.onUpdate = onUpdate
        _editableMountain = State(initialValue: mountain)
    }

    var body: some View {
        VStack(spacing: 8) {
            Picker("Section", selection: $selectedSegment) {
                ForEach(Segment.allCases) { seg in
                    Text(seg.rawValue).tag(seg)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            if selectedSegment == .info {
                MountainInfoView(mountain: $editableMountain)
            } else {
                MountainTrackerView(mountain: $editableMountain)
            }
        }
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
