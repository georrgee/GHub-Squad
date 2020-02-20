//  GFTextField.swift
//  GHub Squad
//  Created by George Garcia on 12/31/19.
//  Copyright © 2019 GeeTeam. All rights reserved.

import UIKit

class GFTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth  = 2
        layer.borderColor  = UIColor.systemGray4.cgColor
        
        textColor                 = .label // Light Mode = black, Dark Mode = white
        tintColor                 = .label // tintColor = for the blinking cursor
        textAlignment             = .center
        font                      = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true // if a user has a long username, it will shrink
        minimumFontSize           = 12 // Want to shrink, but minimum size is 12
        
        backgroundColor    = .tertiarySystemBackground // very lighter color but not super bold
        autocorrectionType = .no
        
        returnKeyType      = .go
        clearButtonMode    = .whileEditing
        placeholder = "Tap to enter a username"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
