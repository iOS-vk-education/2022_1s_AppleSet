//
//  DeviceCellDataModel.swift
//  ITS
//
//  Created by Natalia on 20.11.2022.
//

import UIKit

struct DeviceCellDataModel {
    func loadPlaces() -> [DeviceCellModel] {
        let devices: [DeviceCellModel] = [
            .init(name: "Температура",
                  values: "22",
                  image: UIImage(named: "tempreture")),
            .init(name: "Влажность",
                  values: "22",
                  image: UIImage(named: "humidity")),
            .init(name: "Свет",
                  values: "Выключен",
                  image: UIImage(named: "light")),
            .init(name: "Давление",
                  values: "753 мм рт.ст.",
                  image: UIImage(named: "presser")),
            .init(name: "Шум",
                  values: "50 децибел",
                  image: UIImage(named: "noise"))]
        
        return devices
    }
}
