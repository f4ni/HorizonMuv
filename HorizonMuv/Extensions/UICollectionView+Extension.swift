//
//  UICollectionView+Extension.swift
//  HorizonMuv
//
//  Created by Furkan ic on 16.10.2022.
//

import UIKit

extension UICollectionView{
    func reloadInMainThread(){
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
