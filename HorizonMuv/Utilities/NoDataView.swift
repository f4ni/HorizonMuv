//
//  NoDataView.swift
//  HorizonMuv
//
//  Created by Furkan ic on 18.10.2022.
//

import UIKit

class NoDataView: UIView{

    var imageView: UIImageView!
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel(frame: .zero)
        label.text = "Listelenecek bir şey yok"
        label.textAlignment = .center
        
        var config = UIImage.SymbolConfiguration(scale: .large)
        
        if #available(iOS 15.0, *) {
            config = UIImage.SymbolConfiguration(paletteColors: [.systemTeal, .systemGray5])
        } else {
            // Fallback on earlier versions
        }
        config = config.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 42)))
        
        imageView =  UIImageView(image: UIImage(systemName: "lasso.and.sparkles", withConfiguration: config))
        imageView.contentMode = .scaleAspectFit
        
        addSubview(imageView)
        addSubview(label)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([ imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                      imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                                      imageView.heightAnchor.constraint(equalToConstant: 72),
                                      imageView.widthAnchor.constraint(equalToConstant: 72)
                                      ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
