//
//  APIService.swift
//  HorizonMuv
//
//  Created by Furkan ic on 16.10.2022.
//

import Alamofire

final class APIService{
    
    func retrieveMovies(for word: String, completion: @escaping (AFResult<SearchMovieResponseDTO>) -> ()){

        NetworkHelper.shared.performRequest(route: .searchMovie(word: word), completion: completion)
        
//        guard let url = URL(string: APIURLs.movies(page: page)) else { return }
//
//        NetworkHelper.shared.performRequest(url: url) { [weak self] result in
//            switch result {
//            case .success(let data):
//                break
//            case .failure(let error):
//                self.handler
//            }
//        }
    }
//
//    private func handleWithError(_ error: Error) {
//        print(error.localizedDescription)
//    }
//
//    private func handleWithData(_ data: Date, ) -> SearchMovieResponseDTO?{
//        do {
//            return try JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
//        } catch {
//            print(error);
//            return nil
//        }
//    }
}
