//
//  Request.swift
//  hw3
//
//  Created by Berksu Kısmet on 6.10.2022.
//

import Foundation

// request to iTunesSearch API
struct Request<MediaTypeResponse: Decodable> : DataRequest {
    typealias Response = MediaTypeResponse
    
    var searchText: String
    var mediaName: String
    
    // define base url
    var baseURL: String {
        "https://itunes.apple.com"
    }
    
    // define aim
    var url: String {
        "/search"
    }
    
    // define type of the method
    var method: HTTPMethod {
        .get
    }
    
    // define query
    var queryItems: [String : String] {
        ["term": searchText,
         "entity": mediaName]
    }
    
    // decode the response
    func decode(_ data: Data) throws -> MediaTypeResponse {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(MediaTypeResponse.self, from: data)
        return response
    }
}
