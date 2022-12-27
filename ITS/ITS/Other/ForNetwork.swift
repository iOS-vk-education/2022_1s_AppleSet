//
//  ForNetwork.swift
//  ITS
//
//  Created by Всеволод on 27.12.2022.
//

import Foundation


struct WiFiModel: Decodable {
    let ssid: String
    let isOpen: Bool
}

struct Networks: Decodable {
    let networks: [WiFiModel]
}

struct Status: Decodable {
    let status: StatusName
}

struct DeviceInfo: Decodable {
    let topic: String
}

enum StatusName: Int, Decodable {
    case WL_IDLE_STATUS = 0
    case WL_NO_SSID_AVAIL = 1
    case WL_CONNECTED = 3
    case WL_CONNECT_FAILED = 4
    case WL_CONNECT_WRONG_PASSWORD = 6
    case WL_DISCONNECTED = 7
}
