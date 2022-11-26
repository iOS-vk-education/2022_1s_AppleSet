//
//  PlaceCellDataModel.swift
//  ITS
//
//  Created by Natalia on 20.11.2022.
//

import UIKit

// БД должна подгружаться с бэка, но тк бэка пока нет, создаём её сами
struct GroupCellDataModel {
    func loadGroups() -> [GroupCellModel] {
        let groups: [GroupCellModel] = [.init(name: "Балкон"),
                                        .init(name: "Теплица с помидорами"),
                                        .init(name: "Гостинная"),
                                        .init(name: "Кухня"),
                                        .init(name: "Детская"),
                                        .init(name: "Спальня"),
                                        .init(name: "Ванная"),
                                        .init(name: "Гараж"),
                                        .init(name: "Теплица с огурцами"),
                                        .init(name: "Коридор"),
                                        .init(name: "Погреб"),
                                        .init(name: "Подвал"),
                                        .init(name: "Чердак")]
        
        return groups
    }
}
