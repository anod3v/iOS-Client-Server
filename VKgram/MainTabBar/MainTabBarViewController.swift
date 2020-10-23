//
//  MainTabBarViewController.swift
//  VKgram
//
//  Created by Andrey on 20/09/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = UIColor.white
        setupBar()
        
    }
    
    
    func setupBar() {
        
        let userFriendsViewController = createNavigationController(vc: UserFriendsViewController(), selected: UIImage(systemName: "person.fill")!, unselected: UIImage(systemName: "person")!)
        let userGroupsViewController = createNavigationController(vc: UserGroupsViewController(), selected: UIImage(systemName: "person.2.fill")!, unselected: UIImage(systemName: "person.2")!)
        let newsFeedViewController = createNavigationController(vc: NewsFeedViewController(), selected: UIImage(systemName: "person.2.fill")!, unselected: UIImage(systemName: "person.2")!)
        
        viewControllers = [newsFeedViewController, userFriendsViewController, userGroupsViewController]
        
        guard let items = tabBar.items else { return }
        
        for item in items { // TODO: to check why it is not working (to slightly shift the images down)
            item.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0) // TODO: to put in constants
        }
    }
}

extension UITabBarController {
    func createNavigationController(vc: UIViewController, selected: UIImage, unselected: UIImage) -> UINavigationController {
        let viewController = vc
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.image = unselected
        navigationController.tabBarItem.selectedImage = selected
        return navigationController
    }
}
