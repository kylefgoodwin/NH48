//
//  MountainDetailView.swift
//  NH48
//
//  Created by Kyle Goodwin on 8/3/25.
//

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

    init(mountain: Mountain, onUpdate: @escaping (Mountain) -> Void) {
        self.mountain = mountain
        self.onUpdate = onUpdate
        _editableMountain = State(initialValue: mountain)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(editableMountain.location.uppercased())
                        .font(.caption.bold())
                        .tracking(1.5)
                        .foregroundColor(.secondary)
                    
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text(editableMountain.name)
                            .font(.largeTitle.bold())
                            .foregroundColor(.primary)
                        
                        if editableMountain.isCompleted {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.green)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 8)

                // Segment Picker
                Picker("Section", selection: $selectedSegment) {
                    ForEach(Segment.allCases) { seg in
                        Text(seg.rawValue).tag(seg)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                // Content Section
                if selectedSegment == .info {
                    MountainInfoView(mountain: $editableMountain)
                        .padding(.horizontal)
                } else {
                    MountainTrackerView(mountain: $editableMountain)
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .backgroundGradientStyle()
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

extension View {
    func backgroundGradientStyle() -> some View {
        self.background(
            LinearGradient(
                colors: [Color(.systemGroupedBackground), Color(.secondarySystemGroupedBackground)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}
