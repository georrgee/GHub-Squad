//  SearchController.swift
//  GHub Squad

//  Created by George Garcia on 12/30/19.
//  Copyright © 2019 GeeTeam. All rights reserved.

import UIKit

class SearchController: UIViewController {
    
    let logoImageView      = UIImageView()
    let usernameTextField  = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

    override func viewDidLoad() { // gets called once
        super.viewDidLoad()
        view.backgroundColor = .systemBackground // Light mode = white, Dark Mode = black
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
    }
    
    override func viewWillAppear(_ animated: Bool) { // gets called whenever you go to a specific screen
        super.viewWillAppear(animated) // most of the time you want to call the super. if you didnt call the super, you dont want the parent function to be called where you get all the funtionality for free
        
        navigationController?.isNavigationBarHidden = true
        
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImageView) // just like adding an outlet when using storyboard
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = #imageLiteral(resourceName: "gh-logo")
        
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: .none, bottom: .none, trailing: .none, padding: .init(top: 80, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 200))
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        NSLayoutConstraint.activate([
//            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
//            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            logoImageView.heightAnchor.constraint(equalToConstant: 200), // try to layout your assets in a sqaure images because it makes layouts easier
//            logoImageView.widthAnchor.constraint(equalToConstant: 200)
//        ])
    }
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        
        usernameTextField.anchor(top: logoImageView.bottomAnchor, leading: view.leadingAnchor, bottom: .none, trailing: view.trailingAnchor, padding: .init(top: 48, left: 50, bottom: 0, right: 50), size: .init(width: 0, height: 50))
        
//        NSLayoutConstraint.activate([
//            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
//            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
//            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
//            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
//        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        
        callToActionButton.anchor(top: .none, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 50, right: 50), size: .init(width: 0, height: 50))
        
//        NSLayoutConstraint.activate([
//            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
//            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
//            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
//            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
    }
}
