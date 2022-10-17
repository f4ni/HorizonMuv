//
//  MovieDetailViewModel.swift
//  HorizonMuv
//
//  Created by Furkan ic on 17.10.2022.
//

import Foundation

protocol MovieDetailViewModelInterface {
    var view: MovieDetailViewController? { get set }
    
    func viewDidLoad()
}

class MovieDetailViewModel{
    weak var view: MovieDetailViewController?
    var movie: Movie!
}

extension MovieDetailViewModel: MovieDetailViewModelInterface{
    func viewDidLoad() {
        view?.configureVC()
        view?.downloadPosterImage()
        view?.placeMovieData()
    }
}
