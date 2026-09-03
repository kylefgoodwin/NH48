//
//  GridHeaderSection.swift
//  NH48
//
//  Created by Kyle Goodwin on 9/2/26.
//


import SwiftUI

struct GridHeaderSection: View {
    let title: String
    let count: Int
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(.title3, design: .rounded).weight(.bold))
                .foregroundStyle(.white)
            
            Spacer()
            
            Text("\(count) peaks")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.white.opacity(0.8))
        }
        .padding(.horizontal)
        .padding(.top, 4)
    }
}