//
//  MountainStore.swift
//  NH48
//
//  Created by Kyle Goodwin on 8/5/25.
//


import Foundation
import SwiftUI

class MountainStore: ObservableObject {
    @Published var mountains: [Mountain] = []
    
    init() {
        loadData()
    }

    func updateMountain(_ updated: Mountain) {
        if let index = mountains.firstIndex(where: { $0.id == updated.id }) {
            mountains[index] = updated
            saveData()
        }
    }
}
