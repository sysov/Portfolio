//
//  LocationViewController.swift
//  XOneTask
//
//  Created by Valera Sysov on 1.02.22.
//

import UIKit
import Firebase

final class LocationViewController: UIViewController {
    
    let header = Header()
    let baseViewShadow = BaseViewShadow()
    let locationView = LocationView()
    var photosUrls = [URL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = R.color.baseWhite()
        view.addSubview(header)
        setUpHeaderView()
        view.addSubview(baseViewShadow)
        setUpBaseViewShadow()
        view.addSubview(locationView)
        setUpLocationView()
    }
    
    private func setUpBaseViewShadow() {
        baseViewShadow.translatesAutoresizingMaskIntoConstraints = false
        baseViewShadow.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 30).isActive = true
        baseViewShadow.heightAnchor.constraint(equalToConstant: self.view.frame.size.height / 2.7).isActive = true
        baseViewShadow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        baseViewShadow.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    private func setUpLocationView() {
        locationView.translatesAutoresizingMaskIntoConstraints = false
        locationView.leadingAnchor.constraint(equalTo: baseViewShadow.leadingAnchor, constant: 15).isActive = true
        locationView.trailingAnchor.constraint(equalTo: baseViewShadow.trailingAnchor, constant: -15).isActive = true
        locationView.topAnchor.constraint(equalTo: baseViewShadow.topAnchor, constant: 17).isActive = true
        locationView.bottomAnchor.constraint(equalTo: baseViewShadow.bottomAnchor, constant: -18).isActive = true
        locationView.delegate = self
    }
    
    private func setUpHeaderView() {
        header.translatesAutoresizingMaskIntoConstraints = false
        header.topAnchor.constraint(equalTo: view.topAnchor, constant: 89).isActive = true
        header.heightAnchor.constraint(equalToConstant: 74.73).isActive = true
        let headerWidth = self.view.frame.size.width - 0.2 * (self.view.frame.size.width)
        header.widthAnchor.constraint(equalToConstant: headerWidth).isActive = true
        header.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

extension LocationViewController: LocationViewDelegate {
    func textFieldLocation(text: String?) {
        guard let text = text else { return }
        let net = NetworkManager.shared
        net.getItemList(path: text) { list in
            _ = list.map { [weak self] ref in
                net.getImageURL(by: ref) { [weak self] url in
                    guard let self = self else { return }
                    self.photosUrls.append(url)
                    self.locationView.sendPhotos(photos: self.photosUrls)
                }
            }
        }
        photosUrls.removeAll()
    }
    
    func imagesViewDidPressPhotoCell(index: Int) {
        let selectedImage = photosUrls[index]
        let vc = PhotoImageViewController()
        vc.setUpPhoto(photoUrl: selectedImage)
        navigationController?.pushViewController(vc, animated: true)
    }
}
