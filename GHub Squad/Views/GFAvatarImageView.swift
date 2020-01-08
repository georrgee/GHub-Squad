//
//  GFAvatarImageView.swift
//  GHub Squad
//
//  Created by George Garcia on 1/7/20.
//  Copyright © 2020 GeeTeam. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeHolderImage = #imageLiteral(resourceName: "avatar-placeholder")

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds      = true // you want the image to be inside the imageview
        image              = placeHolderImage
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
