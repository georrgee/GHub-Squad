//  FavoritesController.swift
//  GHub Squad
//  Created by George Garcia on 12/30/19.
//  Copyright © 2019 GeeTeam. All rights reserved.

import UIKit

class FavoritesController: GFDataLoadingController {
    
    let tableView = UITableView()
    var favoritesArray: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame      = view.bounds // fill up the whole view
        tableView.rowHeight  = 80   // "Hey we, the cell rows, are going to be this tall
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    func getFavorites() {
        PersistenceManager.retreiveFavorites { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                
                if favorites.isEmpty {
                    self.tableView.isHidden = true
                    self.showEmptyStateView(with: "You don't have any favorites!\nAdd a person from the Follower screen", in: self.view)
                } else {
                    self.favoritesArray = favorites
                    DispatchQueue.main.async { self.tableView.reloadData() }
                    self.view.bringSubviewToFront(self.tableView) // just in case if the emptyState gets populated on top of it
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "For sure")
            }
        }

    }
}

extension FavoritesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite = favoritesArray[indexPath.row]
        cell.set(favorite: favorite)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favoritesArray[indexPath.row]
        let destVC   = FollowersListController(username: favorite.login)        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(favoriteFollower: favoritesArray[indexPath.row], actionType: .remove) { [weak self] (error) in
            
            guard let self = self else { return }
            
            guard let error = error else {
                self.favoritesArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            self.presentGFAlertOnMainThread(title: "Unable to remove user", message: error.rawValue, buttonTitle: "No problem")
        }
    }
}

// .systemGray -> using system are colors that automatically adapt depending on the appearance state (Light or Dark)


// Why have the data source in the view controller?
// 1. if it is complex 100% move it out of the viewcontroller for example several Sections
// 2. if it is very simple, it's just straightforward. Unnecessary complexity
