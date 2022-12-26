//
//  DatabaseManager.swift
//  ITS
//
//  Created by Natalia on 13.12.2022.
//

import UIKit
import FirebaseFirestore

protocol DatabaseManagerDescription {
    func loadDevices(completion: @escaping (Result<[DeviceCellModel], Error>) -> Void)
    func addDevice(device: CreateDeviceData, completion: @escaping (Result<Void, Error>) -> Void)
    func delDevice(device: CreateDeviceData, completion: @escaping (Result<Void, Error>) -> Void)
    func seeAllDevices(completion: @escaping (Result<[DeviceCellModel], Error>) -> Void)
    
    func loadGroups(completion: @escaping (Result<[GroupCellModel], Error>) -> Void)
    func addGroup(group: CreateGroupData, completion: @escaping (Result<Void, Error>) -> Void)
    func delGroup(group: CreateGroupData, completion: @escaping (Result<Void, Error>) -> Void)
    
    func loadDevicesInGroup(group: String, completion: @escaping (Result<[DeviceCellModel], Error>) -> Void)
    func addDeviceToGroup(group: String, device: CreateDeviceData, completion: @escaping (Result<Void, Error>) -> Void)
    func delDeviceFromGroup(group: String, device: CreateDeviceData, completion: @escaping (Result<Void, Error>) -> Void)
}

enum DatabaseManagerError: Error {
    case noDocuments
}

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private func configureFB() -> Firestore {
        
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        return db
        
    }
    
    // MARK: - devices
    
    func loadDevices(completion: @escaping (Result<[DeviceCellModel], Error>) -> Void) {
        
        let db = configureFB()
        
        db.collection("allDevices").addSnapshotListener { snap, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let devices = snap?.documents else {
                completion(.failure(DatabaseManagerError.noDocuments))
                return
            }
            
            var devicesList = [DeviceCellModel]()
            
            for device in devices {
                let data = device.data()
                let name = data["name"] as! String
                let model = DeviceCellModel.init(name: name)
                devicesList.append(model)
            }
            
            completion(.success(devicesList))
        }
    }
    
    func addDevice(device: CreateDeviceData, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let db = configureFB()
        let name: String = device.dict()["name"] as! String
        
        db.collection("allDevices").document(name).setData(["name": name])
        
    }
    
    func delDevice(device: CreateDeviceData, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let db = configureFB()
        let name: String = device.dict()["name"] as! String
        
        db.collection("allDevices").document(name).delete()
        
    }
    
    func seeAllDevices(completion: @escaping (Result<[DeviceCellModel], Error>) -> Void) {
        
        let db = configureFB()
        var devicesList: [DeviceCellModel] = []
        
        db.collection("allDevices").getDocuments { snap, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let devices = snap?.documents else {
                completion(.failure(DatabaseManagerError.noDocuments))
                return
            }
            
            for device in devices {
                let data = device.data()
                let name = data["name"] as! String
                let model = DeviceCellModel.init(name: name)
                devicesList.append(model)
                
            }
            
            completion(.success(devicesList))
            
        }

    }
    
    // MARK: - groups
    
    func loadGroups(completion: @escaping (Result<[GroupCellModel], Error>) -> Void) {
        
        let db = configureFB()
        
        db.collection("allGroups").addSnapshotListener { snap, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let groups = snap?.documents else {
                completion(.failure(DatabaseManagerError.noDocuments))
                return
            }
            
            var groupsList = [GroupCellModel]()
            
            for group in groups {
                let data = group.data()
                let name = data["name"] as! String
                let devices = data["devices"] as! [String]
                let model = GroupCellModel.init(name: name, devices: devices)
                groupsList.append(model)
            }
            
            completion(.success(groupsList))
        }
    }
    
    func addGroup(group: CreateGroupData, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let db = configureFB()
        let name: String = group.dict()["name"] as! String
        let devices: [String] = group.dict()["devices"] as! [String]
        
        db.collection("allGroups").document(name).setData(["name": name, "devices": devices])
        
    }
    
    func delGroup(group: CreateGroupData, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let db = configureFB()
        let name: String = group.dict()["name"] as! String
        
        db.collection("allGroups").document(name).delete()
        
    }
    
    // MARK: - devices in group
    
    func loadDevicesInGroup(group: String, completion: @escaping (Result<[DeviceCellModel], Error>) -> Void) {
        
        let db = configureFB()
        
        db.collection("allGroups").addSnapshotListener { snap, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let groups = snap?.documents else {
                completion(.failure(DatabaseManagerError.noDocuments))
                return
            }
            
            var devicesList = [DeviceCellModel]()
            
            for g in groups {
                let data = g.data()
                let name = data["name"] as! String
                
                if (name == group) {
                    let devices = data["devices"] as! [String]
                    
                    for device in devices {
                        let model = DeviceCellModel.init(name: device)
                        devicesList.append(model)
                    }
                    
                    break
                }
            }
            
            completion(.success(devicesList))
        }
    }
    
    func addDeviceToGroup(group: String, device: CreateDeviceData, completion: @escaping (Result<Void, Error>) -> Void) {

        let db = configureFB()
        var devicesList: [String] = []
        
        db.collection("allGroups").getDocuments { snap, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let groups = snap?.documents else {
                completion(.failure(DatabaseManagerError.noDocuments))
                return
            }
            
            for g in groups {
                let data = g.data()
                let name = data["name"] as! String
                
                if (name == group) {
                    let devices = data["devices"] as! [String]
                    
                    for d in devices {
                        devicesList.append(d)
                    }
                    
                    devicesList.append(device.dict()["name"] as! String)
                    
                    break
                }
            }
            
            db.collection("allGroups").document(group).updateData(["devices": devicesList])
            
        }

    }

    func delDeviceFromGroup(group: String, device: CreateDeviceData, completion: @escaping (Result<Void, Error>) -> Void) {

        let db = configureFB()
        var devicesList: [String] = []
        
        db.collection("allGroups").getDocuments { snap, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let groups = snap?.documents else {
                completion(.failure(DatabaseManagerError.noDocuments))
                return
            }
            
            for g in groups {
                let data = g.data()
                let name = data["name"] as! String
                
                if (name == group) {
                    let devices = data["devices"] as! [String]
                    
                    for d in devices {
                        if d != device.dict()["name"] as! String {
                            devicesList.append(d)
                        }
                    }
                    
                    break
                }
            }
            
            db.collection("allGroups").document(group).updateData(["devices": devicesList])
            
        }
    }
}
