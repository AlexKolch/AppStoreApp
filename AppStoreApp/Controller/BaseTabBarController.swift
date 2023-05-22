//
//  BaseTabBarController.swift
//  AppStoreApp
//
//  Created by Алексей Колыченков on 22.05.2023.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [createNavController(viewController: UIViewController(),
                                               title: "Today", imageName: "today_icon"),
                           createNavController(viewController: UIViewController(),
                                               title: "Apps", imageName: "apps"),
                           createNavController(viewController: AppsSearchController(),
                                               title: "Search", imageName: "search")]
    }

    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
}
