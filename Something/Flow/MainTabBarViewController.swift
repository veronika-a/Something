//
//  MainTabBarViewController.swift
//  Something
//
//  Created by Veronika Andrianova on 25.01.2022.
//

import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let firstVC = FlowViewController()
        let secondVC = ViewController()
        
        viewControllers = [
            generateNavigationController(rootViewController: firstVC, title: "First", image: .add),
            generateNavigationController(rootViewController: secondVC, title: "Second", image: .remove)
        ]
        
        
    }
    
    private func generateNavigationController(
        rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
            let navigationVC = UINavigationController(rootViewController: rootViewController)
            navigationVC.tabBarItem.image = image
            navigationVC.tabBarItem.title = title
        return navigationVC
    }
}
