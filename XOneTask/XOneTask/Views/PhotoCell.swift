//
//  PhotoCell.swift
//  XOneTask
//
//  Created by Valera Sysov on 1.02.22.
//

import UIKit
import Kingfisher

final class PhotoCell: UICollectionViewCell {
    
    private let photoImage: UIImageView = {
        let photoImage = UIImageView()
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        return photoImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpPhotoImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImage(with imageUrl: URL) {
        photoImage.kf.setImage(with: imageUrl)
    }
    
    private func setUpPhotoImage() {
        addSubview(photoImage)
        photoImage.contentMode = .scaleAspectFill
        photoImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        photoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        photoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        photoImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        photoImage.layer.masksToBounds = true
        photoImage.layer.cornerRadius = 12
    }
}
