//  GFEmptyStateView.swift
//  GHub Squad
//  Created by George Garcia on 1/10/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLabel  = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func configure() {
        addSubview(messageLabel)
        addSubview(logoImageView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor     = .secondaryLabel
        
        logoImageView.image = #imageLiteral(resourceName: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150).isActive = true
        messageLabel.anchor(top: .none, leading: self.leadingAnchor, bottom: .none, trailing: self.trailingAnchor, padding: .init(top: 0, left: 40, bottom: 0, right: 40), size: .init(width: 0, height: 200))
        
        logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 1.3).isActive = true // take the width
        logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, constant: 1.3).isActive = true
        logoImageView.anchor(top: .none, leading: .none, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 40, right: -170))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
