//
//  BaseViewShadow.swift
//  XOneTask
//
//  Created by Valera Sysov on 1.02.22.
//

import UIKit

final class BaseViewShadow: View {
    
    override func setup() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 33
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 0.38, green: 0.417, blue: 0.415, alpha: 0.17).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 8
        self.layer.shadowOffset = CGSize(width: -10, height: 16)
    }
}
