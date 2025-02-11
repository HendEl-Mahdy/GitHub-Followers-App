//
//  TabBarViewController.swift
//  GitHub Followers
//
//  Created by Hend El Mahdy on 04/02/2025.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapBarView()
    }
    
    func setupTapBarView(){
        self.tabBar.backgroundColor = .systemBackground
        UITabBar.appearance().tintColor = .systemGreen
        self.viewControllers = [createSearchUserNavigationController(), createFavoriteUsersNavigationController()]
    }
    
    func createSearchUserNavigationController() -> UINavigationController {
        let searchUserVC = UserSearchViewController()
        searchUserVC.title = "Search"
        searchUserVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchUserVC)
    }
    
    func createFavoriteUsersNavigationController() -> UINavigationController {
        let favoriteUsersVC = FavoriteUsersViewController()
        favoriteUsersVC.title = "Favorites"
        favoriteUsersVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoriteUsersVC)
    }

}
