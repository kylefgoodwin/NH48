//
//  MountainGrid.swift
//  NH48
//
//  Created by Kyle Goodwin on 9/2/26.
//


import SwiftUI

struct MountainGrid: View {
    let filteredMountains: [Mountain]
    let columns: [GridItem]
    @ObservedObject var store: MountainStore
    
    var body: some View {
        if filteredMountains.isEmpty {
            VStack(spacing: 12) {
                Image(systemName: "arrow.up.and.mountain")
                    .font(.system(size: 48))
                    .foregroundStyle(.white.opacity(0.6))
                    .padding(.top, 20)
                Text("No Peaks Found")
                    .font(.headline)
                    .foregroundStyle(.white)
                Text("Try clearing or broadening your search parameters.")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 40)
        } else {
            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(filteredMountains) { mountain in
                    NavigationLink(value: mountain) {
                        MountainCardView(mountain: mountain) {
                            store.toggleCompletion(for: mountain)
                        }
                        .environmentObject(store)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 24)
        }
    }
}
