//
//  Photos.swift
//  BGSoftTask
//
//  Created by Valera Sysov on 16.02.22.
//

import UIKit

final class Photos {
    
    var name : String = ""
    var colors: [String] = []
    var imageURL: String = ""
    var photo_url: String = ""
    var user_name: String = ""
    var user_url:  String = ""
    var cellID = UUID().uuidString
    
    init(dictionary: [String: Any], name: String) {
        self.colors = dictionary["colors"] as? [String] ?? []
        self.photo_url = dictionary["photo_url"] as? String ?? ""
        self.user_name = dictionary["user_name"] as? String ?? ""
        self.user_url = dictionary["user_url"] as? String ?? ""
        self.name = name
    }
}
