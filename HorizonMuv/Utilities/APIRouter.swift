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
    case moviewDetail(id: String)
    
    private var omdbURL: String { "https://www.omdbapi.com" }
    
    private var baseURL: String {
        switch self {
        case .searchMovie, .moviewDetail:
            return omdbURL
        case .posterImage(let url):
            return url
        }
    }
    
    private var apiKey: String {
        "2250ebc5"
    }
    
    private var path: String {
        switch self {
        case .searchMovie, .moviewDetail:
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
        case .moviewDetail(let id):
            return [ "i" : id]
        }
    }

    func asURLRequest() throws -> URLRequest {
        
        let url = baseURL + path

        var urlRequest = try URLRequest(url: url, method: .get)

        switch self {
            
        case .searchMovie, .moviewDetail:
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
