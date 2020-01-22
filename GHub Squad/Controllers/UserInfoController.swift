//  UserInfoController.swift
//  GHub Squad
//  Created by George Garcia on 1/22/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

class UserInfoController: UIViewController {
    
    var userName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        createNavBarUI()
    }
    
    func createNavBarUI() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func dismissViewController() {
        print("Done button tapped!")
        dismiss(animated: true)
    }

}
