//  GFAlertContainerView.swift
//  GHub Squad
//  Created by George Garcia on 2/24/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

class GFAlertContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 16
        layer.borderWidth  = 2
        layer.borderColor  = UIColor.white.cgColor
        backgroundColor    = .systemBackground
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
