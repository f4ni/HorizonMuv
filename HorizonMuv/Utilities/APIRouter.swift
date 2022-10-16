//
//  APIURLs.swift
//  HorizonMuv
//
//  Created by Furkan ic on 16.10.2022.
//

import Alamofire
import Foundation

enum APIRouter: URLRequestConvertible {
    
    case searchMovie(word: String)
    case posterImage(url: String)
    
    static func movies(page: Int) -> String {
        "https://www.omdbapi.com/?apikey=\(page)&"
    }
    
    private var baseURL: String {
        switch self {
        case .searchMovie:
            return "https://www.omdbapi.com"
        case .posterImage(let url):
            return url
        }
    }
    
    private var apiKey: String {
        "2250ebc5"
    }
    
    private var path: String {
        switch self {
        case .searchMovie:
            return "/?apikey=\(apiKey)"
        case .posterImage:
            return ""
        }
    }
    
    private var parameter: Parameters? {
        switch self{
        case .searchMovie(let word):
            return [ "s" : word]
        case .posterImage:
            return nil
        }
    }

    func asURLRequest() throws -> URLRequest {
        
        let url = baseURL + path

        var urlRequest = try URLRequest(url: url, method: .get)

        switch self {
            
        case .searchMovie:
            var urlComponents = URLComponents()

            var parameters = [URLQueryItem]()
            
            if let parameter {
                parameters = parameter.map({ URLQueryItem(name: $0.key, value: String(describing: $0.value)) })
            }
            parameters.append( URLQueryItem(name: "apikey", value: apiKey))
                               
            urlComponents.queryItems = parameters
            
            urlRequest.url = urlComponents.url(relativeTo: urlRequest.url)
            
            return urlRequest
            
        case .posterImage:
            return urlRequest
        }
    }
}
