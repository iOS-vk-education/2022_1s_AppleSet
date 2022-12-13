//
//  DeviceCellDataModel.swift
//  ITS
//
//  Created by Natalia on 26.11.2022.
//

import UIKit

struct DeviceCellDataModel {
    func loadDevices() -> [DeviceCellModel] {
        let devices: [DeviceCellModel] = [.init(name: "Device 1"),
                                          .init(name: "Device 2"),
                                          .init(name: "Device 3"),
                                          .init(name: "Device 4"),
                                          .init(name: "Device 5"),
                                          .init(name: "Device 6"),
                                          .init(name: "Device 7"),
                                          .init(name: "Device 8"),
                                          .init(name: "Device 9"),
                                          .init(name: "Device 10"),
                                          .init(name: "Device 11"),
                                          .init(name: "Device 12"),
                                          .init(name: "Device 13")]
        
        return devices
    }
}
