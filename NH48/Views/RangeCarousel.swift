//
//  RangeCarousel.swift
//  NH48
//
//  Created by Kyle Goodwin on 9/2/26.
//


import SwiftUI

struct RangeCarousel: View {
    let rangesWithCounts: [(name: String, count: Int)]
    @Binding var selectedFilter: MountainFilter
    @Binding var selectedRange: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("EXPLORE BY MOUNTAIN RANGE")
                .font(.system(size: 10, weight: .bold))
                .tracking(1.5)
                .foregroundStyle(.white.opacity(0.85))
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    // "All Ranges" Pill
                    Button {
                        withAnimation(.snappy) {
                            selectedFilter = .all
                            selectedRange = nil
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "square.grid.2x2.fill")
                            Text("All Ranges")
                        }
                        .font(.subheadline.weight(.semibold))
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background {
                            if selectedRange == nil && selectedFilter != .range {
                                Color.white
                            } else {
                                Color.clear.background(.ultraThinMaterial)
                            }
                        }
                        .foregroundStyle(selectedRange == nil && selectedFilter != .range ? .black : .white)
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(Color.white.opacity(selectedRange == nil ? 0.3 : 0.1), lineWidth: 1)
                        )
                    }
                    
                    // Individual Ranges Pills
                    ForEach(rangesWithCounts, id: \.name) { range in
                        let isSelected = selectedRange == range.name && selectedFilter == .range
                        Button {
                            withAnimation(.snappy) {
                                selectedFilter = .range
                                selectedRange = range.name
                            }
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "mountain.2.fill")
                                    .font(.caption)
                                Text(range.name)
                                Text("\(range.count)")
                                    .font(.caption2.weight(.bold))
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(isSelected ? Color.blue.opacity(0.15) : .white.opacity(0.2))
                                    .foregroundStyle(isSelected ? .blue : .white)
                                    .clipShape(Circle())
                            }
                            .font(.subheadline.weight(.semibold))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background {
                                if isSelected {
                                    Color.white
                                } else {
                                    Color.clear.background(.ultraThinMaterial)
                                }
                            }
                            .foregroundStyle(isSelected ? .black : .white)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color.white.opacity(isSelected ? 0.3 : 0.1), lineWidth: 1)
                            )
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}