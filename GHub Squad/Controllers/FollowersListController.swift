//  FollowersListController.swift
//  GHub Squad
//  Created by George Garcia on 1/2/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

class FollowersListController: UIViewController {
    
    var username: String!
    
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureViewController()
        fetchFollowers() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //navigationController?.isNavigationBarHidden            = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewLayout())
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
    }
    
    private func fetchFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { (result) in
            
            switch result {
                case .success(let followers):
                    print("Followers.count = \(followers.count)")
                    print(followers)
                case .failure(let error):
                    print("Error on getFollowers!")
                    self.presentGFAlertOnMainThread(title: "Test - Bad Stuff", message: error.rawValue, buttonTitle: "Thank you!")
                default:
                    return
            }
        }
    }
}

// when passing data, you need to pass a variable on this screen (This ViewController) to be set
