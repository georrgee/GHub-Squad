//  UserInfoController.swift
//  GHub Squad
//  Created by George Garcia on 1/22/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

class UserInfoController: UIViewController {
    
    let headerView       = UIView()
    let itemViewOne      = UIView()
    let itemViewTwo      = UIView()
    var itemViews: [UIView] = []
    
    var userName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNavBarUI()
        layoutUI()
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
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderController(user: user), to: self.headerView)
                    self.add(childVC: GFRepoItemController(user: user), to: self.itemViewOne)
                    self.add(childVC: GFFollowerItemController(user: user), to: self.itemViewTwo)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong...", message: error.rawValue, buttonTitle: "Okay")
            }
        }
    }
    
    func layoutUI() {
        
        view.backgroundColor = .systemBackground

        itemViews = [headerView, itemViewOne, itemViewTwo]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
                
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: .none, trailing: view.trailingAnchor, padding: .init(top: 0, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: 180))
        
        itemViewOne.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: .none, trailing: view.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: itemHeight))
        
        NSLayoutConstraint.activate([
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight)
        ])
        
//        itemViewTwo.anchor(top: itemViewOne.bottomAnchor, leading: view.leadingAnchor, bottom: .none, trailing: view.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: itemHeight))
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
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

