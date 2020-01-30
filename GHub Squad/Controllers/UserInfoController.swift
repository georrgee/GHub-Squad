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
        getUserInfo()
    }
    
    func createNavBarUI() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                print(user.login)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong...", message: error.rawValue, buttonTitle: "Okay")
            }
        }
    }
    
    @objc func dismissViewController() {
        print("Done button tapped!")
        dismiss(animated: true)
    }

}

// closures are either nonescaping or escaping.
// @escaping - can out live this function - use for asynchronous stuff
// closure has to out live the function
// @nonescaping means it does not live longer than the function call

