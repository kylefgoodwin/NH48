//
//  PieProgressView.swift
//  NH48
//
//  Created by Kyle Goodwin on 8/6/25.
//


import SwiftUI

struct PieProgressView: View {
    var progress: Double  
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.2)
                .foregroundColor(.green)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .foregroundColor(.green)
                .rotationEffect(.degrees(-90)) // Start at top
            
            Text("\(Int(progress * 100))%")
                .font(.title2)
                .bold()
        }
        .frame(width: 100, height: 100)
    }
}
