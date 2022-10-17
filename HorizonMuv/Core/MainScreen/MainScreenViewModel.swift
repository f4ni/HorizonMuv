//
//  MainScreenViewModel.swift
//  HorizonMuv
//
//  Created by Furkan ic on 16.10.2022.
//

import Foundation

protocol MainScreenViewModelInterface{
    var view: MainScreenInterface? { get set }

    func viewDidLoad()
    func retrieveSearchedMovies(word: String)
    func retrieveMovieDetail(imdbID: String)
    func clearData()
}

final class MainScreenViewModel{
    
    weak var view: MainScreenInterface?
    
    private let service = APIService()
    
    var movies = [Movie]()

}

extension MainScreenViewModel {
    
}

extension MainScreenViewModel: MainScreenViewModelInterface{
    func retrieveMovieDetail(imdbID: String) {
        service.retrieveMoviewDetail(imdbID: imdbID) { [weak self] resul in
            guard let self else { return }
            
            switch resul {
            case .success(let data):
                self.view?.openDetailScreen(movie: data)
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
   
    func viewDidLoad(){
        view?.configureVC()
        view?.configureSearchBar()
        view?.configureCollectionView()
        view?.addNoDataImageView()
    }

    func retrieveSearchedMovies(word: String) {
        service.retrieveMovies(for: word) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.movies = data._movies
                self.view?.reloadCollectionView()
                if data.movies == nil{
                    self.view?.showAlert(with: "Oops!", message: "Aradığın kriterde birşey bulamadık!")
                    self.view?.addNoDataImageView()
                }
                else{
                    self.view?.removeNoDataImageView()
                }
                
            case .failure(let error):
                self.view?.showAlert(with: "Oops!", message: error.localizedDescription)
                print(error.localizedDescription)
            }
        }
    }
      
    func clearData() {
        movies.removeAll()
        self.view?.reloadCollectionView()
        view?.addNoDataImageView()
    }
}
