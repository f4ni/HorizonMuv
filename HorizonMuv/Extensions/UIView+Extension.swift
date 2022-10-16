//
//  UIView+Extension.swift
//  HorizonMuv
//
//  Created by Furkan ic on 16.10.2022.
//

import UIKit

extension UIView {
    func pinToEgdesOf(view: UIView){
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
