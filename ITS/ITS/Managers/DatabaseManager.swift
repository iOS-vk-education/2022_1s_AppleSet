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
}
