//  SearchController.swift
//  GHub Squad

//  Created by George Garcia on 12/30/19.
//  Copyright © 2019 GeeTeam. All rights reserved.

import UIKit

class SearchController: UIViewController {
    
    let logoImageView      = UIImageView()
    let usernameTextField  = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    var logoImageViewTopConstraint: NSLayoutConstraint!
    
    var isUsernameEntered: Bool { return !usernameTextField.text!.isEmpty } // computed property

    override func viewDidLoad() { // gets called once
        super.viewDidLoad()
        view.backgroundColor = .systemBackground // Light mode = white, Dark Mode = black
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) { // gets called whenever you go to a specific screen
        super.viewWillAppear(animated) // most of the time you want to call the super. if you didnt call the super, you dont want the parent function to be called where you get all the funtionality for free
        
        //navigationController?.isNavigationBarHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true)
        usernameTextField.text = ""
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))) // causes the view to resign the first responder status
        view.addGestureRecognizer(tap)
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImageView) // just like adding an outlet when using storyboard
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant)
        logoImageViewTopConstraint.isActive = true
        
        logoImageView.anchor(top: .none, leading: .none, bottom: .none, trailing: .none, padding: .init(top: 80, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 200))
        logoImageView.centerXInSuperview()
    }
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        
        usernameTextField.delegate = self // self being the SearchController itself
        
        usernameTextField.anchor(top: logoImageView.bottomAnchor, leading: view.leadingAnchor, bottom: .none, trailing: view.trailingAnchor, padding: .init(top: 48, left: 50, bottom: 0, right: 50), size: .init(width: 0, height: 50))
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        
        callToActionButton.addTarget(self, action: #selector(pushToFollowersVC), for: .touchUpInside)
        
        callToActionButton.anchor(top: .none, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 50, right: 50), size: .init(width: 0, height: 50))
    }
    
    @objc func pushToFollowersVC() { // this is how you pass data
        
        guard isUsernameEntered else { 
            print("NO USERNAME!")
            presentGFAlertOnMainThread(title: "Empty Username!", message: "Oops! Looks like there is no username. Please enter a valid username so we can know who to look for 😬", buttonTitle: "Sounds good")
            return
        }
        
        usernameTextField.resignFirstResponder()
        
        let followersVC = FollowersListController(username: usernameTextField.text!)
        
        navigationController?.pushViewController(followersVC, animated: true)
    }
}

extension SearchController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Did Tap Return!")
        
        return true
    }
    
}

/*
 
 //        NSLayoutConstraint.activate([
 //            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
 //            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
 //            logoImageView.heightAnchor.constraint(equalToConstant: 200), // try to layout your assets in a sqaure images because it makes layouts easier
 //            logoImageView.widthAnchor.constraint(equalToConstant: 200)
 //        ])
 
 //        NSLayoutConstraint.activate([
 //            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
 //            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
 //            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
 //            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
 //        ])
 
 
 //        NSLayoutConstraint.activate([
 //            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
 //            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
 //            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
 //            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
 //        ])
 
 
 // command + control + spacebar for Emojis 
 
 */
