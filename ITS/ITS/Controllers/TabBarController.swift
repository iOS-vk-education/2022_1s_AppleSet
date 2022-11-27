//
//  TabBarController.swift
//  ITS
//
//  Created by Natalia on 27.11.2022.
//

import UIKit
import PinLayout

final class TabBarController: UITabBarController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateTabBar()
        setTabBarAppearance()
        
    }
    
    // MARK: - Generate tab bar
    
    private func generateTabBar() {
        viewControllers = [
            generateNC(viewController: GroupsViewController(),
                       title: "Groups",
                       image: UIImage(systemName: "folder")),
            
            generateNC(viewController: AllDevicesViewController(),
                       title: "All devices",
                       image: UIImage(systemName: "list.bullet.rectangle"))
        ]
    }
    
    // MARK: - Generate navigation controller
    
    private func generateNC(viewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        
        viewController.title = title
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        
        return UINavigationController(rootViewController: viewController)
    }
    
    // MARK: - Set tab bar appearance
    
    private func setTabBarAppearance() {

        let roundLayer: CAShapeLayer = CAShapeLayer()
        
        roundLayer.fillColor = UIColor.tabBarColor.cgColor
        
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
}
