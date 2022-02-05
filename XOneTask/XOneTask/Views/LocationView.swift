//
//  LocationView.swift
//  XOneTask
//
//  Created by Valera Sysov on 1.02.22.
//

import UIKit

protocol LocationViewDelegate: AnyObject {
    func imagesViewDidPressPhotoCell(index: Int)
    func textFieldLocation(text: String?)
}

final class LocationView: View {
    
    private struct Constants {
        static let cellIdentifyer = "cell"
    }
    
    weak var delegate: LocationViewDelegate?
    
    private var photosUrlsInCollection = [URL]()
    
    private let textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let addButton: UIButton = {
        let addButton = UIButton(frame: .zero)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        return addButton
    }()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    @objc private func addButton(_ sender:UIButton!) {
        delegate?.textFieldLocation(text: textField.text)
        photosUrlsInCollection.removeAll()
        
      
    }
    
    override func setup() {
        self.layer.backgroundColor = UIColor(red: 0.929, green: 0.953, blue: 0.957, alpha: 1).cgColor
        self.layer.cornerRadius = 12
        self.addSubview(addButton)
        setUpAddButton()
        self.addSubview(textField)
        setUpTextField()
        self.addSubview(collectionView)
        setUpCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let flowLayout = UICollectionViewFlowLayout()
        let cellHeight = (collectionView.frame.height - 10) / 2
        let cellWidth = (collectionView.frame.width - 10 * 2) / 3
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets.zero
        collectionView.collectionViewLayout = flowLayout
    }
    
    private func setUpAddButton() {
        addButton.setBackgroundImage(R.image.buttomImage(), for: UIControl.State.normal)
        addButton.addTarget(self, action:#selector(self.addButton(_:)), for: .touchUpInside)
        addButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func setUpTextField() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        let attributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor(red: 0.525, green: 0.58, blue: 0.584, alpha: 1),
            .font: R.font.ubuntu(size: 23),
            .paragraphStyle: paragraphStyle
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Название локации", attributes: attributes as [NSAttributedString.Key: Any])
        
        textField
            .topAnchor
            .constraint(equalTo: self.topAnchor, constant: 10)
            .isActive = true
        
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        textField.trailingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: -30).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    private func setUpCollectionView() {
        collectionView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: Constants.cellIdentifyer)
    }
    
    func sendPhotos(photos: [URL]) {
        photosUrlsInCollection = photos
        collectionView.reloadData()
    }
}

extension LocationView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return photosUrlsInCollection.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        delegate?.imagesViewDidPressPhotoCell(index: indexPath.row)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifyer, for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        cell.setupImage(with: photosUrlsInCollection[indexPath.row])
        return cell
    }
}

