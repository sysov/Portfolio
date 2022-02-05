//
//  PhotoImageViewController.swift
//  XOneTask
//
//  Created by Valera Sysov on 1.02.22.
//

import UIKit
import Kingfisher

final class PhotoImageViewController: UIViewController {
    
    private let photoView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackgroundView()
        view.addSubview(photoView)
        setUpConstrains()
    }
    
    func setUpPhoto(photoUrl: URL) {
        photoView.kf.setImage(with: photoUrl)
    }
    
    private func setUpBackgroundView() {
        view.backgroundColor = .black
    }
    
    private func setUpConstrains() {
        photoView.contentMode = .scaleAspectFit
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        photoView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        photoView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
