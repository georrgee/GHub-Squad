//  GFRepoItemController.swift
//  GHub Squad
//  Created by George Garcia on 2/11/20.
//  Copyright © 2020 GeeTeam. All rights reserved.
//

import UIKit

protocol GFRepoItemControllerDelegate: class {
    func didTapGithubProfile(for user: User)
}

class GFRepoItemController: GFItemInfoController {
    
    weak var delegate: GFRepoItemControllerDelegate!
    
    init(user: User, delegate: GFRepoItemControllerDelegate) {
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
        itemInfoView1.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoView2.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
    }
}
