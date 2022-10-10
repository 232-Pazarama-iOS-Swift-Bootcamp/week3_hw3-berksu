//
//  Ebook.swift
//  hw3
//
//  Created by Berksu Kısmet on 5.10.2022.
//

import Foundation

// MARK: - Ebook Model
struct Ebook: MediaProtocol{
    let trackId: Int?
    let name: String?
    let writer: String?
    let artworkLarge: URL?
    let description: String?
    let releaseDate: String?
    let price: Double?
    let userRatingCount: Int?
    let averageUserRating: Double?
    
    enum CodingKeys: String, CodingKey{
        case trackId
        case name = "trackName"
        case writer = "artistName"
        case artworkLarge  = "artworkUrl100"
        case description
        case releaseDate
        case price
        case userRatingCount
        case averageUserRating
    }
}
