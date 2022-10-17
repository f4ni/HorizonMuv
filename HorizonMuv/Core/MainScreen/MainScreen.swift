//
//  ViewController.swift
//  HorizonMuv
//
//  Created by Furkan ic on 15.10.2022.
//

import UIKit

protocol MainScreenInterface: AnyObject {
    func configureVC()
    func configureCollectionView()
    func configureSearchBar()
    func reloadCollectionView()
}

class MainScreen: UIViewController {
    
    private let viewModel = MainScreenViewModel()
    
    private var collectionView: UICollectionView!
    private var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
    
}

extension MainScreen: MainScreenInterface{

    func configureVC() {
        title = "Find Your Movie 🎥"
        view.backgroundColor = .systemBackground
    }

    func configureSearchBar() {
        searchBar = UISearchBar(frame: .zero)
        view.addSubview(searchBar)
        
        searchBar.delegate = self
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                      searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                      searchBar.heightAnchor.constraint(equalToConstant: 36)
                                    ])
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createMainCollectionViewFlowLayout())
        
        view.addSubview(collectionView)
        collectionView.pinToEgdesOf(view: view)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reusableID)
    }
    
    func reloadCollectionView() {
        collectionView.reloadInMainThread()
    }
    
}

extension MainScreen: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reusableID, for: indexPath) as! MovieCollectionViewCell
        let movie = viewModel.movies[indexPath.item]
        cell.setCell(movie: movie)
        
        return cell
    }
extension MainScreen: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text.count > 2{
            viewModel.retrieveSearchedMovies(word: text)
        }
        else {
            viewModel.clearData()
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewModel.clearData()
        }
    }
}
