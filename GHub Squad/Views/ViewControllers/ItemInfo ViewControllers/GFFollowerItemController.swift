//  GFFollowerItemController.swift
//  GHub Squad
//  Created by George Garcia on 2/11/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

class GFFollowerItemController: GFItemInfoController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoView1.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoView2.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
