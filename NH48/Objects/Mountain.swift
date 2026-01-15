//
//  Mountain.swift
//  NH48
//
//  Created by Kyle Goodwin on 8/3/25.
//

import Foundation

struct Mountain: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var elevation: Int
    var location: String
    var description: String?
    var latitude: Double?
    var longitude: Double?
    var isCompleted: Bool
    var image: String? = nil

    // Tracker fields
    var personalNotes: String? = nil
    var completionDate: Date? = nil
    var rating: Int? = nil
    var difficulty: Int? = nil
    var conditions: [String]? = nil
    var distanceMiles: Double? = nil
    var elevationGain: Int? = nil
    var durationMinutes: Int? = nil
    var tags: [String] = []
    var photoFileNames: [String] = []
}

