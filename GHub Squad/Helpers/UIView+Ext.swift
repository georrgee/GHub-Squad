//  UIView+Ext.swift
//  GHub Squad
//  Created by George Garcia on 2/26/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

extension UIView {
    
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: superview.topAnchor, leading: superview.leadingAnchor, bottom: superview.bottomAnchor, trailing: superview.trailingAnchor)
    }
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
}

// Variadic Parameters = class...
// example: func addSubviews(_ views: UIView...)
// 1. Basically says, I can pass in any number of views into addSubviews
// 2. Automatically turns (views) into an array that you can use in the scope of your function
