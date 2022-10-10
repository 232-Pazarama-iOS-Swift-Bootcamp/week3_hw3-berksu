//
//  PodcastResponse.swift
//  hw3
//
//  Created by Berksu Kısmet on 6.10.2022.
//

import Foundation

// MARK: - Response Model
struct Response<Media: MediaProtocol>: Decodable {
    let resultCount: Int?
    let results: [Media]?
}
