//
//  FavoriteCell.swift
//  GHub Squad
//
//  Created by George Garcia on 2/19/20.
//  Copyright © 2020 GeeTeam. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuseID: String = "FavoriteCell"
    let avatarImageView        = GFAvatarImageView(frame: .zero) // .zero becaue we are going to adjust this
    let userNameLabel          = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    private func configure() {
        addSubviews(avatarImageView, userNameLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        avatarImageView.centerYInSuperview()
        avatarImageView.anchor(top: .none, leading: self.leadingAnchor, bottom: .none, trailing: .none, padding: .init(top: 0, left: padding, bottom: 0, right: 0), size: .init(width: 60, height: 60))
        
        userNameLabel.centerYInSuperview()
        userNameLabel.anchor(top: .none, leading: avatarImageView.trailingAnchor, bottom: .none, trailing: self.trailingAnchor, padding: .init(top: 0, left: 24, bottom: 0, right: padding), size: .init(width: 0, height: 40))
    }
    
    func set(favorite: Follower) {
        avatarImageView.downloadImage(from: favorite.avatarUrl)
        userNameLabel.text = favorite.login
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
