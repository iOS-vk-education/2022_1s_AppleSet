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
        let groups: [GroupCellModel] = [.init(name: "Group 1"),
                                        .init(name: "Group 2"),
                                        .init(name: "Group 3"),
                                        .init(name: "Group 4"),
                                        .init(name: "Group 5"),
                                        .init(name: "Group 6"),
                                        .init(name: "Group 7"),
                                        .init(name: "Group 8"),
                                        .init(name: "Group 9"),
                                        .init(name: "Group 10"),
                                        .init(name: "Group 11"),
                                        .init(name: "Group 12"),
                                        .init(name: "Group 13")]
        
        return groups
    }
}
