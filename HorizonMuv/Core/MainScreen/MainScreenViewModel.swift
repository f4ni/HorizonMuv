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
}

final class MainScreenViewModel{
    
    weak var view: MainScreenInterface?
    
    private let service = APIService()
    
    var movies = [Movie]()

}

extension MainScreenViewModel {
    

    
}

extension MainScreenViewModel: MainScreenViewModelInterface{
   
    func viewDidLoad(){
        view?.configureVC()
        view?.configureCollectionView()
        
        retrieveSearchedMovies(word: "hell")
    }

    func retrieveSearchedMovies(word: String) {
        service.retrieveMovies(for: word) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.movies = data._movies
                self.view?.reloadCollectionView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
      
}
