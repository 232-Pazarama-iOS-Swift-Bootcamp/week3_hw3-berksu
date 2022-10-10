//
//  NetworkService.swift
//  hw3
//
//  Created by Berksu Kısmet on 6.10.2022.
//

import Foundation

protocol NetworkService {
    func request<Request: DataRequest>(_ request: Request, compilation: @escaping (Result<Request.Response, Error>) -> Void)
}

// All network service
struct BaseNetworkService: NetworkService {
    func request<Request>(_ request: Request, compilation: @escaping (Result<Request.Response, Error>) -> Void) where Request : DataRequest {
        
        // Control urlComponent and return error
        guard var urlComponent = URLComponents(string: request.baseURL + request.url) else {
            let error = NSError(domain: ErrorResponse.invalidResponse.rawValue, code: 404, userInfo: nil)
            return compilation(.failure(error))
        }
        
        var queryItems = [URLQueryItem]()
        
        request.queryItems.forEach { key, value in
            let urlQueryItem = URLQueryItem(name: key, value: value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }
        
        urlComponent.queryItems = queryItems
        
        // Control url and return error
        guard let url = urlComponent.url else {
            let error = NSError(domain: ErrorResponse.invalidEndpoint.rawValue, code: 404, userInfo: nil)
            return compilation(.failure(error))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                return compilation(.failure(error))
            }
            
            // Control response and return error
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                let error = NSError(domain: ErrorResponse.responseNotFound.rawValue, code: 404, userInfo: nil)
                return compilation(.failure(error))
            }
            
            // Control data and return error
            guard let data = data else {
                let error = NSError(domain: ErrorResponse.responseNotFound.rawValue, code: 404, userInfo: nil)
                return compilation(.failure(error))
            }
            
            do{
                try compilation(.success(request.decode(data)))
            }catch let error as NSError{
                compilation(.failure(error))
            }
            
        }.resume()
    }
}
