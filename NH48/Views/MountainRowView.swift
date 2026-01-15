//
//  MountainRowView.swift
//  NH48
//
//  Created by Kyle Goodwin on 8/5/25.
//


import SwiftUI

struct MountainRowView: View {
    let mountain: Mountain

    var body: some View {
        NavigationLink {
            MountainMapView(mountain: mountain)
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(mountain.name)
                        .font(.headline)
                    Text("\(mountain.elevation) ft")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 4)
            .padding(.horizontal)
        }
    }
}
