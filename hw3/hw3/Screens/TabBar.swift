//
//  TabBar.swift
//  hw3
//
//  Created by Berksu Kısmet on 5.10.2022.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupViewControllers()
    }
    
    // Create all of the tabs and icons of the tabs
    func setupViewControllers(){
        viewControllers = [
            createNavigationController(for: ViewController<Podcast>("podcast"),
                                       title: NSLocalizedString("Podcast", comment: ""),
                                       image: UIImage(systemName: "earpods")!),
            createNavigationController(for: ViewController<Movie>("movie"),
                                       title: NSLocalizedString("Movie", comment: ""),
                                       image: UIImage(systemName: "film")!),
            createNavigationController(for: ViewController<Music>("song"),
                                       title: NSLocalizedString("Music", comment: ""),
                                       image: UIImage(systemName: "music.note")!),
            createNavigationController(for: ViewController<Software>("software"),
                                       title: NSLocalizedString("Software", comment: ""),
                                       image: UIImage(systemName: "pc")!),
            createNavigationController(for: ViewController<Ebook>("ebook"),
                                       title: NSLocalizedString("E-Book", comment: ""),
                                       image: UIImage(systemName: "book")!)
        ]
    }
    
    fileprivate func createNavigationController(for rootViewController: UIViewController,
                                                title: String,
                                                image: UIImage) -> UIViewController{
        // add navigation controller to each tab
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navigationController
    }
 
}

