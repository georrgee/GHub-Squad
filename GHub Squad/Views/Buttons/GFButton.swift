//  GFButton.swift
//  GHub Squad
//  Created by George Garcia on 12/30/19.
//  Copyright © 2019 GeeTeam. All rights reserved.

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) { // how big is this button?
        // using override is do to some customization
        super.init(frame: frame) // everything apple built, we are calling the original class with its code
        configure()
    }
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius      = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false // this basically says we want to use AutoLayout
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// UIFont - Dynamic Type: Readjustable Font Size. (Think of the settings app where you want to increase the text size)

