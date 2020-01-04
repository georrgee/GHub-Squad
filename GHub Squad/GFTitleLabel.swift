//  GFTitleLabel.swift
//  GHub Squad
//  Created by George Garcia on 1/3/20.
//  Copyright © 2020 GeeTeam. All rights reserved.
import UIKit

class GFTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
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
