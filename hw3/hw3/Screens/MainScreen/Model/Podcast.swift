//
//  Podcast.swift
//  hw3
//
//  Created by Berksu Kısmet on 5.10.2022.
//

import Foundation

// MARK: - Podcast Model
struct Podcast: MediaProtocol{
    let trackId: Int?
    let artistName: String?
    let name: String?
    let artworkLarge: URL?
    let releaseDate: String?
    let country: String?
    let genres: [String]?
    let price: Double?
    
    enum CodingKeys: String, CodingKey{
        case trackId
        case artistName
        case name = "trackName"
        case artworkLarge = "artworkUrl600"
        case releaseDate
        case country
        case genres
        case price = "trackPrice"
    }
}
