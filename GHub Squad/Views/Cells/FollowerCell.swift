//  FollowerCell.swift
//  GHub Squad
//  Created by George Garcia on 1/7/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID: String = "FollowerCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero) // .zero becaue we are going to adjust this
    let userNameLabel   = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    let padding: CGFloat  = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func set(follower: Follower) {
        userNameLabel.text = follower.login
        
        NetworkManager.shared.downloadImage(from: follower.avatarUrl) { [weak self] (image) in
            guard let self = self else { return }
            
            DispatchQueue.main.async { self.avatarImageView.image = image }
        }
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(userNameLabel)
        
        avatarImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: .none, trailing: contentView.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding))
        avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor).isActive = true
        
        userNameLabel.anchor(top: avatarImageView.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))
        userNameLabel.constrainHeight(constant: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
