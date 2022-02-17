//
//  GalleryViewController.swift
//  BGSoftTask
//
//  Created by Valera Sysov on 16.02.22.
//

import UIKit

final class GalleryViewController: UIViewController {
    
    lazy var collectionView = GalleryCollectionView()
    let photoStoreg = NetworkingManager()
    private var photos = [Photos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        getPhotos()
    }
    
    private func setUpCollectionView() {
        collectionView = GalleryCollectionView(frame: self.view.bounds)
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.register(PhotoViewCell.self, forCellWithReuseIdentifier: PhotoViewCell.identifier)
        collectionView.delegate   = self
        collectionView.dataSource = self
    }
    
    private func getPhotos() {
        var authorPhoto: [Photos] = []
        do {
            if let file = URL(string: "https://dev.bgsoft.biz/task/credits.json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                guard let object = json as? [String: Any] else { return }
                for dict in object {
                    let photo = Photos(dictionary: dict.value as! [String:Any], name: dict.key)
                    authorPhoto.append(photo)
                }
                authorPhoto.sort{ ($0.user_name < $1.user_name) }
                for model in authorPhoto {
                    let url = "https://dev.bgsoft.biz/task/" + model.name + ".jpg"
                    let imageUrl = URL(string: url)
                    guard let imageUrl = imageUrl else {return}
                    photoStoreg.downloadImage(from: imageUrl) {
                        print("Image don't download")
                    }
                    model.imageURL = url
                    self.photos.append(model)
                    print(self.photos.count)
                }
            } else {
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoViewCell.identifier, for: indexPath) as! PhotoViewCell
        let object = photos[indexPath.row]
        cell.authorLabel.text = object.user_name
        cell.photoLink = object.photo_url
        cell.userLink = object.user_url
        cell.setObject(object: object)
        cell.delegat = self
        return cell
    }
}

