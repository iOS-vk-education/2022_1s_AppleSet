//
//  DeviceCellDataModel.swift
//  ITS
//
//  Created by Natalia on 26.11.2022.
//

import UIKit

struct DeviceCellDataModel {
    func loadDevices() -> [DeviceCellModel] {
        let devices: [DeviceCellModel] = [.init(name: "Устройство 1"),
                                          .init(name: "Устройство 2"),
                                          .init(name: "Устройство 3"),
                                          .init(name: "Устройство 4"),
                                          .init(name: "Устройство 5"),
                                          .init(name: "Устройство 6"),
                                          .init(name: "Устройство 7"),
                                          .init(name: "Устройство 8"),
                                          .init(name: "Устройство 9"),
                                          .init(name: "Устройство 10"),
                                          .init(name: "Устройство 11"),
                                          .init(name: "Устройство 12"),
                                          .init(name: "Устройство 13")]
        
        return devices
    }
}
