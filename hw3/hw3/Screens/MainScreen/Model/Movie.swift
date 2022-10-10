//
//  Movie.swift
//  hw3
//
//  Created by Berksu Kısmet on 5.10.2022.
//

import Foundation

// MARK: - Movie Model
struct Movie: MediaProtocol{
    let trackId: Int?
    let name: String?
    let artworkLarge: URL?
    let description: String?
    let releaseDate: String?
    let genres: String?
    let price: Double?
    
    enum CodingKeys: String, CodingKey{
        case trackId
        case name = "trackName"
        case artworkLarge = "artworkUrl100"
        case description = "longDescription"
        case releaseDate
        case genres = "primaryGenreName"
        case price = "trackPrice"
    }
    
    func getGenraIDArray() -> [String]? {
        genres?.components(separatedBy: ",")
    }
}
