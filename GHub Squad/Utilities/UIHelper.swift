//  UIHelper.swift
//  GHub Squad
//  Created by George Garcia on 1/9/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

enum UIHelper {
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        
        let width                       = view.bounds.width
        let paddingInset: CGFloat       = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (paddingInset * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth /  3
        
        let flowLayout          = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: paddingInset, left: paddingInset, bottom: paddingInset, right: paddingInset)
        flowLayout.itemSize     = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
}
