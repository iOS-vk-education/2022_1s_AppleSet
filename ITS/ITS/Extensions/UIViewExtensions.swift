//
//  UIView+Extensions.swift
//  ITS
//
//  Created by Natalia on 20.11.2022.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
