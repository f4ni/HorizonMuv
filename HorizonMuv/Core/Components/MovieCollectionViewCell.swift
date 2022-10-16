//
//  MovieCollectionViewCell.swift
//  HorizonMuv
//
//  Created by Furkan ic on 16.10.2022.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let reusableID = "MovieCollectionViewCell"
    
    private var posterImageView: PosterImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell(){
        backgroundColor = .systemGray4
        layer.cornerRadius = 12
        clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
        posterImageView.cancelDownloading()
    }
    
    func setCell(movie: Movie){
        posterImageView.downloadImage(movie: movie)
    }
    
    private func configureImageView(){
        posterImageView = PosterImageView(frame: .zero)
        addSubview(posterImageView)
        
        posterImageView.pinToEgdesOf(view: self)
    }
}
