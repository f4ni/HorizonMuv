//
//  PosterImageView.swift
//  HorizonMuv
//
//  Created by Furkan ic on 16.10.2022.
//

import UIKit
import Kingfisher

class PosterImageView: UIImageView {

    private var dataTask: DownloadTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func downloadImage(movie: Movie){
        guard let url = URL(string: movie._poster) else { return }
        dataTask = self.kf.setImage(with: url)
    }
    
    func cancelDownloading(){
        dataTask?.cancel()
        dataTask = nil
    }
}
