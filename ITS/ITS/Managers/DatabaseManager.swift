//
//  DatabaseManager.swift
//  ITS
//
//  Created by Natalia on 13.12.2022.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseDatabase

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private func configureFB() -> Firestore {
        
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        return db
        
    }
    
    func loadDevices(completion: @escaping ([DeviceCellModel]) -> ()) {
        
        let db = configureFB()
        db.collection("allDevices").getDocuments { snap, error in
            if error == nil {
                var devicesList = [DeviceCellModel]()
                
                if let devices = snap?.documents {
                    for device in devices {
                        let data = device.data()
                        let name = data["name"] as! String
                        let model = DeviceCellModel.init(name: name)
                        devicesList.append(model)
                    }
                }
                
                completion(devicesList)
            }
        }
    }
    
    func addDevice(name: String) {
        
        let db = configureFB()
        db.collection("allDevices").document(name).setData(["name": name])
        
    }
    
    func delDevice(document: String) {
        
        let db = configureFB()
        db.collection("allDevices").document(document).delete()
        
    }
}
