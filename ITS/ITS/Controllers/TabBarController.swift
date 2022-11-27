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
<<<<<<< Updated upstream
                       title: "Devices",
                       image: UIImage(systemName: "folder"))
=======
                       title: "All devices",
                       image: UIImage(systemName: "list.bullet.rectangle"))
>>>>>>> Stashed changes
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
//        let positionOnX: CGFloat = 10
//        let positionOnY: CGFloat = 15
//        let width: CGFloat = tabBar.bounds.width - positionOnX * 2
//        let height: CGFloat = tabBar.bounds.height + positionOnY * 2
//
        let roundLayer: CAShapeLayer = CAShapeLayer()
//
//        let bezierPath: UIBezierPath = UIBezierPath(roundedRect: CGRect(x: positionOnX,
//                                                                        y: tabBar.bounds.minY - positionOnY,
//                                                                        width: width,
//                                                                        height: height),
//                                                    cornerRadius: height / 2)
//
//        roundLayer.path = bezierPath.cgPath
//
//        tabBar.layer.insertSublayer(roundLayer, at: 0)
//
//        tabBar.itemWidth = width / 5
//        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.tabBarColor.cgColor
        
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
}
