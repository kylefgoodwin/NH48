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

    func saveData() {
        if let encoded = try? JSONEncoder().encode(mountains) {
            UserDefaults.standard.set(encoded, forKey: "mountains")
        }
    }

    func loadData() {
        if let saved = UserDefaults.standard.data(forKey: "mountains"),
           let decoded = try? JSONDecoder().decode([Mountain].self, from: saved) {
            mountains = decoded
        } else {
            mountains = sampleMountains
        }
    }

    func toggleCompletion(for mountain: Mountain) {
        if let index = mountains.firstIndex(where: { $0.id == mountain.id }) {
            mountains[index].isCompleted.toggle()
            saveData()
        }
    }
}
