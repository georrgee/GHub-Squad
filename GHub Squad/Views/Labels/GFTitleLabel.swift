//  GFTitleLabel.swift
//  GHub Squad
//  Created by George Garcia on 1/3/20.
//  Copyright © 2020 GeeTeam. All rights reserved.
import UIKit

class GFTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    private func configure() {
        textColor = .label // black on white screen white on black screen
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.9
        
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// benefits of a convenience initilizers
// 1. instead of calling that super long 7 parameter initializer
// 2. create a convience for default values for like 5 of those parameters
// 3. then 2 can be different
// Writing like a cleaner init method


