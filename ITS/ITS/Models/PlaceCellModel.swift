//
//  PlaceCellModel.swift
//  ITS
//
//  Created by Natalia on 20.11.2022.
//

import UIKit

// Данные приходят с бэка
final class PlaceCellModel {
    let name: String
    
    // Инициализация ячейки
    init(name: String = "") {
        self.name = name
    }
}
