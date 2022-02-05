//
//  NetworkManager.swift
//  XOneTask
//
//  Created by Valera Sysov on 3.02.22.
//

import Foundation
import FirebaseStorage

final class NetworkManager {
    
    static var shared = NetworkManager()
    
    private let storageRef = Storage.storage().reference()
    
    func getImageURL(
        by item: StorageReference,
        completion: @escaping (URL) -> Void
    ) {
        item.downloadURL { url, error in
            guard let url = url else { return }
            completion(url)
        }
    }
    
    func getItemList(
        path: String,
        completion: @escaping ([StorageReference]) -> Void
    ) {
        let list = createStorageReference(with: path)
        list.listAll { result, error in
            completion(result.items)
        }
    }
    
    private func createStorageReference(with path: String) -> StorageReference {
        return storageRef.child(path)
    }
    
}
