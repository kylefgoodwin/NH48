//
//  HistoryAndChartCard.swift
//  NH48
//
//  Created by Kyle Goodwin on 9/2/26.
//


import SwiftUI

struct HistoryAndChartCard: View {
    @ObservedObject var store: MountainStore
    
    var body: some View {
        if store.mountains.contains(where: { $0.completionDate != nil }) {
            VStack(alignment: .leading, spacing: 8) {
                Label("Hiking History & Momentum", systemImage: "chart.xyaxis.line")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.white.opacity(0.95))
                
                CompletionChart(store: store)
                    .padding(.top, 4)
            }
            .padding(14)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color.white.opacity(0.12), lineWidth: 1)
            )
            .padding(.horizontal)
        }
    }
}