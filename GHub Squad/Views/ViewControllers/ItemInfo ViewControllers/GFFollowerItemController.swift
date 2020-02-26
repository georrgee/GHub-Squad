//  GFFollowerItemController.swift
//  GHub Squad
//  Created by George Garcia on 2/11/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

protocol GFFollowerItemControllerDelegate: class {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemController: GFItemInfoController {
    
    weak var delegate: GFFollowerItemControllerDelegate!
    
    init(user: User, delegate: GFFollowerItemControllerDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoView1.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoView2.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
