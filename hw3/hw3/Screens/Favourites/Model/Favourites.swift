//
//  Favourites.swift
//  hw3
//
//  Created by Berksu Kısmet on 8.10.2022.
//

import Foundation
import CoreData

// MARK: - Favourites Model
struct Favourites: MediaProtocol{
    var trackId: Int?
    var name: String?
    var artworkLarge: URL?
    var releaseDate: String?
    var price: Double?
}


