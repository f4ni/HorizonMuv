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
    
    static func movies(page: Int) -> String {
        "https://www.omdbapi.com/?apikey=\(page)&"
    }
    
    private var baseURL: String {
        "https://www.omdbapi.com"
    }
    
    private var apiKey: String {
        "2250ebc5"
    }
    
    private var path: String {
        switch self {
        case .searchMovie:
            return "/?"
        }
    }
    
    private var parameter: Parameters? {
        switch self{
        case .searchMovie(let word):
            return [ "s" : word]
        }
    }

    func asURLRequest() throws -> URLRequest {
        
        let url = baseURL + path + "apikey=\(apiKey)"
        
        var urlRequest = try URLRequest(url: url, method: .get)
        
        var urlComponents = URLComponents()

        var parameters = [URLQueryItem]()
        
        if let parameter {
            parameters = parameter.map({ URLQueryItem(name: $0.key, value: String(describing: $0.value)) })
        }
        parameters.append( URLQueryItem(name: "apikey", value: apiKey))
                           
        urlComponents.queryItems = parameters
        
        urlRequest.url = urlComponents.url(relativeTo: urlRequest.url)
        
        return urlRequest
    }
}
