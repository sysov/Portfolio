//
//  OnboardingCollectionViewCell.swift
//  OnboardingTest
//
//  Created by Valera Sysov on 9.04.22.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let indentifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var firstBackgroundView: UIView!
    @IBOutlet weak var lastBackgroundView: UIView!
    @IBOutlet weak var presentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setUp(_ slide: OnboardingSlide) {
        imageView.image = slide.image
        titleLabel.text = slide.title
        subtitleLabel.text = slide.subtitle
    }
}
