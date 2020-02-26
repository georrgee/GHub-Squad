//  GFUserInfoHeaderController.swift
//  GHub Squad
//  Created by George Garcia on 2/3/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

class GFUserInfoHeaderController: UIViewController {
    
    let avatarImageView     = GFAvatarImageView(frame: .zero)
    let usernameLabel       = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel           = GFSecondaryTitleLabel(fontSize: 18)
    
    let locationImageView   = UIImageView()
    let locationLabel       = GFSecondaryTitleLabel(fontSize: 18)
    
    let bioLabel            = GFBodyLabel(textAlignment: .left)
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configureUIElements()
    }
    
    func configureUIElements() {
        downloadAvatarImage()
        
        usernameLabel.text 	    = user.login
        nameLabel.text     	    = user.name ?? ""
        locationLabel.text 	    = user.location ?? "Location Unavaliable"
        bioLabel.text      	    = user.bio ?? "No bio avaliable"
        bioLabel.numberOfLines  = 3
        
        locationImageView.image     = SFSymbols.location
        locationImageView.tintColor = .secondaryLabel
    }
    
    func downloadAvatarImage() {
        NetworkManager.shared.downloadImage(from: user.avatarUrl) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImageView.image = image }
        }
    }
    
    func addSubviews() {
        view.addSubviews(avatarImageView, usernameLabel, nameLabel, locationImageView, locationLabel, bioLabel)
    }
    
    func layoutUI() {
        
        let padding: CGFloat          = 20
        let textImagePadding: CGFloat = 12
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        avatarImageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: .none, trailing: .none, padding: .init(top: padding, left: 0, bottom: 0, right: 0), size: .init(width: 90, height: 90))
        
        usernameLabel.anchor(top: avatarImageView.topAnchor, leading: avatarImageView.trailingAnchor, bottom: .none, trailing: view.trailingAnchor, padding: .init(top: 0, left: textImagePadding, bottom: 0, right: 0), size: .init(width: 0, height: 38))
        
        nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8).isActive = true
        nameLabel.anchor(top: .none, leading: avatarImageView.trailingAnchor, bottom: .none, trailing: view.trailingAnchor, padding: .init(top: 0, left: textImagePadding, bottom: 0, right: 0), size: .init(width: 0, height: 20))
        
        locationImageView.anchor(top: .none, leading: avatarImageView.trailingAnchor, bottom: avatarImageView.bottomAnchor, trailing: .none, padding: .init(top: 0, left: textImagePadding, bottom: 0, right: 0), size: .init(width: 20, height: 20))
        
        locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor).isActive = true
        locationLabel.anchor(top: .none, leading: locationImageView.trailingAnchor, bottom: .none, trailing: view.trailingAnchor, padding: .init(top: 0, left: 5, bottom: 0, right: 0), size: .init(width: 0, height: 20))
        
        bioLabel.anchor(top: avatarImageView.bottomAnchor, leading: avatarImageView.leadingAnchor, bottom: .none, trailing: view.trailingAnchor, padding: .init(top: textImagePadding, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 90))
    }

}

