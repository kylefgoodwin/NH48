//
//  Mountain.swift
//  NH48
//
//  Created by Kyle Goodwin on 8/3/25.
//


// Mountain.swift
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
    var image: String?
}
