//  GFRepoItemController.swift
//  GHub Squad
//  Created by George Garcia on 2/11/20.
//  Copyright © 2020 GeeTeam. All rights reserved.
//

import UIKit

class GFRepoItemController: GFItemInfoController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoView1.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoView2.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
    }
}
