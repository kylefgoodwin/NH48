//
//  MountainCardView.swift
//  NH48
//
//  Created by Kyle Goodwin on 9/24/25.
//


import SwiftUI

let fallbackGradients: [Gradient] = [
    Gradient(colors: [.blue.opacity(0.7), .green.opacity(0.7)]),
    Gradient(colors: [.purple.opacity(0.7), .pink.opacity(0.7)]),
    Gradient(colors: [.orange.opacity(0.7), .red.opacity(0.7)]),
    Gradient(colors: [.teal.opacity(0.7), .indigo.opacity(0.7)]),
    Gradient(colors: [.gray.opacity(0.7), .black.opacity(0.7)])
]


struct MountainCardView: View {
    var mountain: Mountain
    var onToggleCompleted: () -> Void

    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ZStack {
                if let name = mountain.image,
                   UIImage(named: name) != nil {
                    Image(name)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .clipped()
                } else {
                    let gradient = mountain.isCompleted
                        ? Gradient(colors: [.green, .blue])
                        : Gradient(colors: [Color.red.opacity(0.2), Color.red.opacity(0.4)]) 

                    LinearGradient(
                        gradient: gradient,
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 180)
                    .overlay(
                        Image(systemName: "mountain.2.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.white.opacity(0.9))
                    )
                }
            }
            .cornerRadius(16)

            
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(0.6), .clear]),
                startPoint: .bottom,
                endPoint: .center
            )
            .cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(mountain.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Text("\(mountain.elevation) ft")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding()
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: onToggleCompleted) {
                        Image(systemName: mountain.isCompleted ? "mountain.2.fill" : "mountain.2")
                            .foregroundColor(mountain.isCompleted ? .green : .white)
                            .padding(10)
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                    }
                }
                Spacer()
            }
            .padding()
        }
        .padding(.horizontal)
        .shadow(radius: 4)
    }
}


extension Image {
    init(mountainImageName: String?, fallback: String = "mountain.fallback") {
        if let name = mountainImageName, UIImage(named: name) != nil {
            self.init(name) // image exists in assets
        } else {
            self.init(systemName: fallback) // fallback to SF Symbol
        }
    }
}
