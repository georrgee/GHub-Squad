//
//  GFAvatarImageView.swift
//  GHub Squad
//
//  Created by George Garcia on 1/7/20.
//  Copyright © 2020 GeeTeam. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    
    let cache            = NetworkManager.shared.cache
    let placeHolderImage = Images.placeHolder?.withRenderingMode(.alwaysOriginal)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds      = true // you want the image to be inside the imageview
        image              = placeHolderImage
        contentMode        = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Automatic Refernce Counting
// *keeps a count of a reference
// what is a reference:


// example:
// var george: Developer? = Developer(name: "George")
// var spaceGrayMP: Macbook? = Macbook(serialNumber: 23)

// spaceGrayMP.owner = Sean
// george?.machine = spaceGrayMP

// "george" has a reference count of 2

// you should create a weak reference inside the Macbook class, where the property variable "owner" of type Developer 
