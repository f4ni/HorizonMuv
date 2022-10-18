//
//  MovieDetailViewController.swift
//  HorizonMuv
//
//  Created by Furkan ic on 16.10.2022.
//

import UIKit
import FirebaseAnalytics

protocol MoviewDetailViewControllerInterface: AnyObject {
    func configureVC()
    func downloadPosterImage()
    func placeMovieData()
    func sendFAEvent()
}

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: PosterImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var overviewContainerView: UIView!

    private let viewModel: MovieDetailViewModel
    
    init?(coder: NSCoder, viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
        self.viewModel.view = self

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
    }

}

extension MovieDetailViewController: MoviewDetailViewControllerInterface {
    func sendFAEvent() {
        Analytics.logEvent("page_view", parameters: nil)
        
    }
    
    func configurePosterImageView() {
    }
    
    func placeMovieData() {
        titleLabel.text = viewModel.movie._title
        yearLabel.text = viewModel.movie._year
        genreLabel.text = viewModel.movie._genre
        overviewTextView.text = viewModel.movie._overview
    }
    
    func configureVC() {
        view.backgroundColor = .systemGray5
        
        posterImageView.layer.cornerRadius = 12
        posterImageView.clipsToBounds = true
        
        overviewContainerView.layer.cornerRadius = 6
        overviewContainerView.clipsToBounds = true
    }
    
    func downloadPosterImage() {
        posterImageView.downloadImage(movie: viewModel.movie)
    }
}
