//
//  MainTabBarViewController.swift
//  Something
//
//  Created by Veronika Andrianova on 25.01.2022.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let flowVC = FlowViewController()
        let compositionalVC = CompositionalViewController()
        let advansedVC = AdvancedViewController()
        
        viewControllers = [
            generateNavigationController(rootViewController: advansedVC, title: "advansed", image: .add),
            generateNavigationController(rootViewController: flowVC, title: "flow", image: .remove),
            generateNavigationController(rootViewController: compositionalVC, title: "compositional", image: .add)
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
