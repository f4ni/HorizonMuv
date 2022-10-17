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
    func showAlert(with title: String, message: String)
    func addNoDataImageView()
    func removeNoDataImageView()
}

class MainScreen: UIViewController {
    
    private let viewModel = MainScreenViewModel()
    
    private var collectionView: UICollectionView!
    private var searchBar: UISearchBar!
    
    private var noDataView: UIView = {
        let v = UIView(frame: .zero)
        
        let label = UILabel(frame: .zero)
        label.text = "Listelenecek bir şey yok"
        label.textAlignment = .center
        
        var config = UIImage.SymbolConfiguration(paletteColors: [.systemTeal, .systemGray5])
        config = config.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 42)))
        config = config.applying(UIImage.SymbolConfiguration(scale: .large))
        
        var noDataImageView =  UIImageView(image: UIImage(systemName: "lasso.and.sparkles", withConfiguration: config))
        noDataImageView.contentMode = .scaleAspectFit
        
        v.addSubview(noDataImageView)
        v.addSubview(label)
        
        noDataImageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([ noDataImageView.centerXAnchor.constraint(equalTo: v.centerXAnchor),
                                      noDataImageView.centerYAnchor.constraint(equalTo: v.centerYAnchor),
                                      noDataImageView.heightAnchor.constraint(equalToConstant: 72),
                                      noDataImageView.widthAnchor.constraint(equalToConstant: 72)
                                      ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: v.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: v.trailingAnchor),
            label.topAnchor.constraint(equalTo: noDataImageView.bottomAnchor, constant: 12)
        ])
        
        return v
    }()
    
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reusableID)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 12),
                                    ])
    }
    
    func reloadCollectionView() {
        collectionView.reloadInMainThread()
    }
 
    func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        
        self.present(alert, animated: true)
    }
    
    func addNoDataImageView() {
        
        collectionView.addSubview(noDataView)
        
        noDataView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
//            noDataView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
//            noDataView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            noDataView.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: -100),
            noDataView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            noDataView.heightAnchor.constraint(equalToConstant: 100),
                          
                                      ])
    }
    
    func removeNoDataImageView() {
        guard let _ = noDataView.superview else { return }
        
        noDataView.removeFromSuperview()
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
