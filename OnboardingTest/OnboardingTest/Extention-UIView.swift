//
//  Extention-UIView.swift
//  OnboardingTest
//
//  Created by Valera Sysov on 9.04.22.
//
import UIKit

extension UIView {
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor, view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = [0,1]
        gradientLayer.frame = view.bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
