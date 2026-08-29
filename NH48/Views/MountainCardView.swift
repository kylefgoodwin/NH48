//
//  MountainCardView.swift
//  NH48
//
//  Created by Kyle Goodwin on 9/24/25.
//

import SwiftUI

struct MountainCardView: View {
    var mountain: Mountain
    var onToggleCompleted: () -> Void

    private var userImage: UIImage? {
        if let filename = mountain.image, let docImage = ImageStore.loadImage(named: filename) {
            return docImage
        }
        if let firstPhoto = mountain.photoFileNames.first, let docImage = ImageStore.loadImage(named: firstPhoto) {
            return docImage
        }
        return nil
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ZStack {
                if let image = userImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                } else {
                    let gradient = mountain.isCompleted
                        ? LinearGradient(colors: [.green.opacity(0.8), .blue.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
                        : LinearGradient(colors: [Color(.systemGray4), Color(.systemGray6)], startPoint: .topLeading, endPoint: .bottomTrailing)

                    gradient
                        .frame(height: 200)
                        .overlay(
                            Image(systemName: "mountain.2.fill")
                                .font(.system(size: 55))
                                .foregroundStyle(.white.opacity(mountain.isCompleted ? 0.9 : 0.4))
                        )
                }
            }
            .cornerRadius(20)

            // Bottom gradient overlay for legible text
            LinearGradient(
                colors: [.black.opacity(0.75), .black.opacity(0.2), .clear],
                startPoint: .bottom,
                endPoint: .top
            )
            .cornerRadius(20)
            
            // Text metadata
            VStack(alignment: .leading, spacing: 4) {
                Text(mountain.location.uppercased())
                    .font(.caption2.bold())
                    .tracking(1)
                    .foregroundColor(.white.opacity(0.8))
                
                Text(mountain.name)
                    .font(.title3.bold())
                    .foregroundColor(.white)
                
                HStack(spacing: 6) {
                    Label("\(mountain.elevation) ft", systemImage: "arrow.up.forward")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                    
                    if mountain.isCompleted {
                        Text("•")
                            .foregroundColor(.white.opacity(0.6))
                        Label("Completed", systemImage: "checkmark.circle.fill")
                            .font(.subheadline)
                            .foregroundColor(.green)
                    }
                }
            }
            .padding(16)
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: onToggleCompleted) {
                        Image(systemName: mountain.isCompleted ? "mountain.2.fill" : "mountain.2")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(mountain.isCompleted ? .green : .white)
                            .padding(10)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                    }
                    .buttonStyle(.plain)
                    .accessibilityIdentifier("CompletionToggle")
                }
                Spacer()
            }
            .padding(12)
        }
        .padding(.horizontal, 4)
        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
    }
}
