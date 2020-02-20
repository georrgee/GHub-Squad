//  FollowersListController.swift
//  GHub Squad
//  Created by George Garcia on 1/2/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

protocol FollowersListVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class FollowersListController: UIViewController {
    
    enum Section { case main } // enums are hasable by default
    
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>! // declaring the data sourc
    var page: Int = 1
    var hasMoreFollowers: Bool = true
    var isSearching = false // by default (you are not searching... yet)
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title         = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureSearchController()
        configureViewController()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //navigationController?.isNavigationBarHidden            = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addFavoritesButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addFavoritesButton
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
    }
    
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()

            switch result {
                case .success(let followers):
                    if followers.count < 100 { self.hasMoreFollowers = false }
                    self.followers.append(contentsOf: followers) // 100 in the array, download the next page, then add the next followers in the array
                    if self.followers.isEmpty { // isEmpty is more optimized than count == 0
                        let message = "\(self.username ?? "This user") doesn't have any followers! Give them some love ❤️"
                        DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                        return
                    }
                    self.updateData(on: self.followers)
                case .failure(let error):
                    print("Error on getFollowers!")
                    self.presentGFAlertOnMainThread(title: "Test - Bad Stuff", message: error.rawValue, buttonTitle: "Thank you!")
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
    
    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) } // dont need anything in completion (after it completes) 
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater                 = self
        searchController.searchBar.delegate                   = self
        searchController.searchBar.placeholder                = "Search username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController                       = searchController
    }
    
    @objc func addButtonTapped() {
        print("Add Button Tapped")
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistenceManager.updateWith(favoriteFollower: favorite, actionType: .add) { [weak self] (error) in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.presentGFAlertOnMainThread(title: "Success!", message: "Nice! You just favorited this user! 🎉", buttonTitle: "Cool!")
                        return
                    }
                    
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Got it")
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "No problem")
            }
        }
    }
}

extension FollowersListController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y    // up and down (how far we scroll down)
        let contentHeight = scrollView.contentSize.height // entire scrollview
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers // W ? T : F
        let follower = activeArray[indexPath.item]
        
        let destinationController = UserInfoController()
        destinationController.userName = follower.login
        destinationController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: destinationController)
        present(navigationController, animated: true)
    }
}

extension FollowersListController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}

extension FollowersListController: FollowersListVCDelegate {
    func didRequestFollowers(for username: String) {
        // get followers for that user
        self.username = username
        title         = username
        page          = 1
        
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
    }
}

// when passing data, you need to pass a variable on this screen (This ViewController) to be set
// diffabledata source = table and collection view
// Diffable Data Source = when its dynamic, apple introduces this where you no longer need to deal with indexPaths


// What to do for slow connection
// you can go to the simulator settings and test for slow connection

// going through followers array, $0 = item that you are on, check the login, you want to lower case it (that way case sensitive isnt a problem), if it contains the filter, throw that to the filter array

