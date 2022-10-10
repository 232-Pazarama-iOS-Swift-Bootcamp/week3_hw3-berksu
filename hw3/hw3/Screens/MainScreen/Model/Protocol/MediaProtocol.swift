//
//  MediaProtocol.swift
//  hw3
//
//  Created by Berksu Kısmet on 7.10.2022.
//

import Foundation

// MARK: - Common Protocol for all media types
protocol MediaProtocol: Decodable{
    var trackId: Int? { get }
    var name: String? { get }
    var artworkLarge: URL? { get }
    var releaseDate: String? { get }
    var price: Double? { get }
}


