//
//  MoviesDTO.swift
//  HorizonMuv
//
//  Created by Furkan ic on 16.10.2022.
//

import Foundation

struct SearchMovieResponseDTO: Codable{
    let movies: [Movie]?
    let totalResults, response: String?

    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults
        case response = "Response"
    }
    
    var _movies: [Movie]{
        movies ?? [Movie]()
    }
}


struct Movie: Codable {
    let title, year, imdbID, genre, overview: String?
    let type: TypeEnum?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
        case genre = "Genre"
        case overview = "Plot"
    }
    
    var _title: String{
        title ?? "N/A"
    }
    
    var _year: String{
        year ?? "N/A"
    }
    
    var _imdbID: String{
        imdbID ?? "N/A"
    }
    
    var _type: TypeEnum{
        type ?? .notSpecified
    }
    
    var _poster: String{
        poster ?? ""
    }
    
    var _genre: String{
        genre ?? "N/A"
    }
    
    var _overview: String{
        overview ?? "N/A"
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
    case series = "series"
    case game = "game"
    case notSpecified = "not specified"
}
