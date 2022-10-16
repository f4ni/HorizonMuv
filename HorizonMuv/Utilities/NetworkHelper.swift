//
//  NetworkHelper.swift
//  HorizonMuv
//
//  Created by Furkan ic on 16.10.2022.
//

import Alamofire
import Foundation

class NetworkHelper{
    
    static let shared = NetworkHelper()
    private init(){}

    @discardableResult
    func performRequest<T:Decodable>( route: APIRouter, decoder: JSONDecoder = JSONDecoder(), completion: @escaping(AFResult<T>) -> ()) -> DataRequest {
        
            AF.request(route)
            .validate(statusCode: 200..<400)
            .responseDecodable(of: T.self) { response in
                debugPrint(response)
                
                completion(response.result)
                
        }
    }
}
