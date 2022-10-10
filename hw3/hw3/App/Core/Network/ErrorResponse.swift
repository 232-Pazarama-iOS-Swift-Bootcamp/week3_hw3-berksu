//
//  ErrorResponse.swift
//  hw3
//
//  Created by Berksu Kısmet on 6.10.2022.
//

import Foundation

// errors
enum ErrorResponse: Error{
    
    case invalidEndpoint
    case responseNotFound
    case dataNotFound
    case invalidResponse
    
    var rawValue: String{
        switch self{
        case .invalidEndpoint:
            return "Invalid endpoint."
        case .responseNotFound:
            return "Resonse not found."
        case .dataNotFound:
            return "Data not found."
        case .invalidResponse:
            return "Invalid response."
        }
    }
}
