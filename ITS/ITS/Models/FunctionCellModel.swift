//
//  DeviceCellModel.swift
//  ITS
//
//  Created by Dasha on 20.11.2022.
//

import UIKit

final class FunctionCellModel {
    let name: String
//    let image: UIImage?
    let values: String
    
    init(name: String = "", values: String = "") {
        self.name = name
//        self.image = image
        self.values = values
    }
}

