//  GFSecondaryTitleLabel.swift
//  GHub Squad
//  Created by George Garcia on 2/3/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

class GFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    private func configure() {
        font = UIFont.preferredFont(forTextStyle: .body)

        textColor                 = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.90
        lineBreakMode             = .byTruncatingTail
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
