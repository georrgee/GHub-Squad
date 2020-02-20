//  GFTabBarController.swift
//  GHub Squad
//  Created by George Garcia on 2/20/20.
//  Copyright © 2020 GeeTeam. All rights reserved.

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNavigationController(), createFavoritesNavigationController()]
    }
    
    func createSearchNavigationController() -> UINavigationController {
            let searchVC        = SearchController()
            searchVC.title      = "Search"
            searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    
            return UINavigationController(rootViewController: searchVC)
        }
    
    func createFavoritesNavigationController() -> UINavigationController {
            let favoritesVC        = FavoritesController()
            favoritesVC.title      = "Favorites"
            favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    
            return UINavigationController(rootViewController: favoritesVC)
    }
}
