//  FollowersListController.swift
//  GHub Squad
//  Created by George Garcia on 1/2/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

class FollowersListController: UIViewController {
    
    var userName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationController?.isNavigationBarHidden            = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// when passing data, you need to pass a variable on this screen (This ViewController) to be set
