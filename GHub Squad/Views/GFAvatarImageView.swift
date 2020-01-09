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
    let placeHolderImage = #imageLiteral(resourceName: "avatar-placeholder").withRenderingMode(.alwaysOriginal)

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
    
    func downloadImage(from urlString: String) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in // network call
            guard let self = self else { return }
            if error != nil { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async { self.image = image }
        }
        task.resume()
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
