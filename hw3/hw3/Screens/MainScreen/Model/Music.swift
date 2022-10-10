//
//  Music.swift
//  hw3
//
//  Created by Berksu Kısmet on 5.10.2022.
//

import Foundation
 // entitiy: song

// MARK: - Music Model
struct Music: MediaProtocol{
    let trackId: Int?
    let artistName: String?
    let name: String?
    let collectionName: String?
    let artworkLarge: URL?
    let releaseDate: String?
    let genres: String?
    let price: Double?
    
    enum CodingKeys: String, CodingKey{
        case trackId
        case artistName
        case name = "trackName"
        case collectionName
        case artworkLarge = "artworkUrl100"
        case releaseDate
        case genres = "primaryGenreName"
        case price = "trackPrice"
    }

}
