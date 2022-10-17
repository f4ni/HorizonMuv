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
        
    }
    
    func retrieveMoviewDetail(imdbID: String, completion: @escaping(AFResult<Movie>) -> ()){
        NetworkHelper.shared.performRequest(route: .moviewDetail(id: imdbID), completion: completion)
    }

}
