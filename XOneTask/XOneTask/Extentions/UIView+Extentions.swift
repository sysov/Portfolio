//
//  UIView+Extentions.swift
//  XOneTask
//
//  Created by Valera Sysov on 3.02.22.
//

import UIKit

extension UIView {
    func makeCenter(subview: UIView) {
        subview.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        subview.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        subview.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        subview.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
}
