//
//  Software.swift
//  hw3
//
//  Created by Berksu Kısmet on 5.10.2022.
//

import Foundation

// MARK: - Software Model
struct Software: MediaProtocol{
    let trackId: Int?
    let name: String?
    let artworkLarge: URL?
    let description: String?
    let releaseDate: String?
    let genres: [String]?
    let advisories: [String]?
    let supportedDevices: [String]?
    let price: Double?
    
    enum CodingKeys: String, CodingKey{
        case trackId
        case name = "artistName"
        case artworkLarge  = "artworkUrl512"
        case description
        case releaseDate
        case genres
        case advisories
        case supportedDevices
        case price
    }
}
