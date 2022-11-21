//
//  DeviceCellModel.swift
//  ITS
//
//  Created by Dasha on 20.11.2022.
//

import UIKit
// Данные приходят с бэка
final class DeviceCellModel {
    let name: String
    let image: UIImage?
    let values: String
    
    // Инициализация ячейки
    init(name: String = "", values: String = "", image: UIImage? = nil ) {
        self.name = name
        self.image = image
        self.values = values
    }
}

