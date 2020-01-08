//  FollowersListController.swift
//  GHub Squad
//  Created by George Garcia on 1/2/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

class FollowersListController: UIViewController {
    
    enum Section { // enums are hasable by default
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>! // declaring the data sourc

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureViewController()
        fetchFollowers()
        configureDataSource()
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
    }
    
    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        
        let width                       = view.bounds.width
        let paddingInset: CGFloat       = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (paddingInset * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth /  3
        
        let flowLayout          = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: paddingInset, left: paddingInset, bottom: paddingInset, right: paddingInset)
        flowLayout.itemSize     = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    private func fetchFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { (result) in
            
            switch result {
                case .success(let followers):
                    self.followers = followers
                    self.updateData()
                case .failure(let error):
                    print("Error on getFollowers!")
                    self.presentGFAlertOnMainThread(title: "Test - Bad Stuff", message: error.rawValue, buttonTitle: "Thank you!")
                default:
                    return
            }
        }
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) } // dont need anything in completion (after it completes) 
    }
}

// when passing data, you need to pass a variable on this screen (This ViewController) to be set
// diffabledata source = table and collection view
// Diffable Data Source = when its dynamic, apple introduces this where you no longer need to deal with indexPaths
