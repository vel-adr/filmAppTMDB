//
//  TabBarVC.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 23/02/23.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupViewControllers()
    }
    
    func setupViewControllers() {
        viewControllers = [
            createNavController(for: FirstScreenVC(), title: "Dashboard", image: UIImage(systemName: "house") ?? UIImage()),
            createNavController(for: SearchVC(), title: "Search", image: UIImage(systemName: "magnifyingglass") ?? UIImage())
        ]
    }
    
    fileprivate func createNavController(for rootVC: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.tabBarItem.title = title
        navVC.tabBarItem.image = image
        navVC.navigationBar.prefersLargeTitles = true
        rootVC.navigationItem.title = title
        return navVC
    }
}
