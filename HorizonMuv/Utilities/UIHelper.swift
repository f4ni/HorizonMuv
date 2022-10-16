//
//  UIHelper.swift
//  HorizonMuv
//
//  Created by Furkan ic on 16.10.2022.
//

import UIKit

enum UIHelper {
    static func createMainCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = CGFloat.deviceWidth / 2 - 32
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
        layout.minimumLineSpacing = 32
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        return layout
    }
}
