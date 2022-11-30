//
//  UIColorExtensions.swift
//  ITS
//
//  Created by Natalia on 27.11.2022.
//

import UIKit

extension UIColor {
    static var tabBarItemAccent: UIColor {
        #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    static var navigationItem: UIColor = tabBarItemAccent
    
    static var tabBarColor: UIColor {
        #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    static var tabBarItemLight: UIColor {
        #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    static let customLightGrey = UIColor(red: 0xe4 / 255,
                                    green: 0xe5 / 255,
                                    blue: 0xea / 255,
                                    alpha: 1)
    
    static let customGrey = UIColor(red: 0x32 / 255,
                                    green: 0x33 / 255,
                                    blue: 0x34 / 255,
                                    alpha: 1)
    
    static let customBlue = UIColor(red: 0xce / 255,
                                    green: 0xdd / 255,
                                    blue: 0xf0 / 255,
                                    alpha: 1)
    
    class func creatImageWithColor(color:UIColor) -> UIImage {
        
        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context?.fill(rect)
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return colorImage!
    }
}
