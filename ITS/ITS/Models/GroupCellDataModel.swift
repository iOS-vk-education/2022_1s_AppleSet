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
        let groups: [GroupCellModel] = [.init(name: "Group 1", devices: ["1", "2", "3"]),
                                        .init(name: "Group 2", devices: ["1", "2", "3"]),
                                        .init(name: "Group 3", devices: ["1", "2", "3"]),
                                        .init(name: "Group 4", devices: ["1", "2", "3"]),
                                        .init(name: "Group 5", devices: ["1", "2", "3"]),
                                        .init(name: "Group 6", devices: ["1", "2", "3"]),
                                        .init(name: "Group 7", devices: ["1", "2", "3"]),
                                        .init(name: "Group 8", devices: ["1", "2", "3"]),
                                        .init(name: "Group 9", devices: ["1", "2", "3"]),
                                        .init(name: "Group 10", devices: ["1", "2", "3"]),
                                        .init(name: "Group 11", devices: ["1", "2", "3"]),
                                        .init(name: "Group 12", devices: ["1", "2", "3"]),
                                        .init(name: "Group 13", devices: ["1", "2", "3"])]
        
        return groups
    }
}
