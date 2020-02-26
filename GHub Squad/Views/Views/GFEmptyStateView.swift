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
        addSubviews(messageLabel, logoImageView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor     = .secondaryLabel
        
        logoImageView.image = Images.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -150
        let logoBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : 40
        
        messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant).isActive = true
        
        messageLabel.anchor(top: .none, leading: self.leadingAnchor, bottom: .none, trailing: self.trailingAnchor, padding: .init(top: 0, left: 40, bottom: 0, right: 40), size: .init(width: 0, height: 200))
        
        logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3).isActive = true // take the width
        logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3).isActive = true
        logoImageView.anchor(top: .none, leading: .none, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: logoBottomConstant, right: -170))
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -50 : -150
// let messageLabelCenterYConstraint = messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant).isActive = true
