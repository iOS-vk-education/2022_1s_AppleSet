//
//  TabBarController.swift
//  ITS
//
//  Created by Natalia on 27.11.2022.
//

import UIKit
import PinLayout

//protocol TabBarViewDelegate: AnyObject {
//    func hideAddButton()
//}

final class TabBarController: UITabBarController {
    
//    weak var delegate_2: TabBarViewDelegate?
    
    public var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.imageView?.tintColor = .white
        button.imageView?.layer.transform = CATransform3DMakeScale(2, 2, 2)
        button.backgroundColor = .white
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        // button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        button.clipsToBounds = true
        button.frame.size = CGSize(width: 32, height: 2)
        
        return button
    }()
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateTabBar()
        setTabBarAppearance()
//        view.addSubview(addButton)
//        addConstraint()
//        self.tabBar.addSubview(addButton)
        self.tabBar.superview!.insertSubview(addButton, belowSubview: self.tabBar)
        
    }
    
    public func hideAddButton() {
        addButton.isHidden = true
    }
    
    private func addConstraint() {
        
        addButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor).isActive = true
        addButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor).isActive = true
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
        
        roundLayer.fillColor = UIColor.white.cgColor
        
        tabBar.tintColor = .customGrey
        tabBar.unselectedItemTintColor = .customLightGrey
    }

}
