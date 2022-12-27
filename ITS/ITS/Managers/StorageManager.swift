//
//  StorageManager.swift
//  ITS
//
//  Created by Natalia on 27.12.2022.
//

import FirebaseStorage
import UIKit

enum ImageServiceError: Error {
    case jpegDataError
}


final class ImageService {
    private let storageRef = Storage.storage().reference()
    
    static var cache: [String: UIImage] = [:]
    
    func upload(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        let name = UUID().uuidString
        
        guard let imageData = image.jpegData(compressionQuality: 0.2) else {
            completion(.failure(ImageServiceError.jpegDataError))
            return
        }
        
        storageRef.child(name).putData(imageData) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                Self.cache[name] = UIImage(data: imageData)
                completion(.success(name))
            }
        }
    }
    
    func download(imageName: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let image = Self.cache[imageName] {
            completion(.success(image))
            return
        }
        
        let maxSize: Int64 = 10 * 1024 * 1024
        
        storageRef.child(imageName).getData(maxSize: maxSize) { data, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let image = UIImage(data: data) {
                Self.cache[imageName] = image
                completion(.success(image))
            } else {
                completion(.failure(ImageServiceError.jpegDataError))
            }
        }
    }
}
