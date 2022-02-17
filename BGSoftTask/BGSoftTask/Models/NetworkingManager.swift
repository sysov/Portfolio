//
//  NetworkingManager.swift
//  BGSoftTask
//
//  Created by Valera Sysov on 16.02.22.
//

import Foundation
import UIKit

final class NetworkingManager {
    static var imageCashe = NSCache<AnyObject,AnyObject>()
    fileprivate func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL, completion: @escaping () -> Void) {
        let queue = DispatchQueue.global(qos: .background)
        queue.async { [self] in
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    guard let image = UIImage(data: data) else { return }
                    NetworkingManager.imageCashe.setObject(image as UIImage, forKey: url.path as NSString)
                    
                }
            }
        }
    }
}
