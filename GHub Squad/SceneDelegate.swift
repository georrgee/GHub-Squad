//  SceneDelegate.swift
//  GHub Squad
//  Created by George Garcia on 12/30/19.
//  Copyright © 2019 GeeTeam. All rights reserved.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds) // fills up the whole screen
        
        window?.windowScene = windowScene
        
        // setting the root view controller
        window?.rootViewController = GFTabBarController()
        window?.makeKeyAndVisible()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemGreen
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}


//         guard let _ = (scene as? UIWindowScene) else { return } // underscore: variable exists but not giving a name

// every window has a window scene



//    func createSearchNavigationController() -> UINavigationController {
//        let searchVC        = SearchController()
//        searchVC.title      = "Search"
//        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
//
//        return UINavigationController(rootViewController: searchVC)
//    }
//
//    func createFavoritesNavigationController() -> UINavigationController {
//        let favoritesVC        = FavoritesController()
//        favoritesVC.title      = "Favorites"
//        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
//
//        return UINavigationController(rootViewController: favoritesVC)
//    }
    
    
    // my code
//    func createNavigationController(viewController: UIViewController, title: String, tabBarItem: UITabBarItem) -> UINavigationController {
//        let viewController        = viewController
//        viewController.title      = title
//        viewController.tabBarItem = tabBarItem
//
//        return UINavigationController(rootViewController: viewController)
//    }
//
//    func createTabbar() -> UITabBarController {
//        let tabbar = UITabBarController()
//        UITabBar.appearance().tintColor = .systemGreen // Appearance = Overall
//        //tabbar.viewControllers = [searchNavigationController, favoritesNavigationController]
//        tabbar.viewControllers = [createNavigationController(viewController: SearchController(), title: "Search", tabBarItem: .init(tabBarSystemItem: .search, tag: 0)),
//                                  createNavigationController(viewController: FavoritesController(), title: "Favorites", tabBarItem: .init(tabBarSystemItem: .favorites, tag: 1))]
//        return tabbar
//    }
