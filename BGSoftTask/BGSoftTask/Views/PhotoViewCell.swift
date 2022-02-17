//
//  PhotoViewCell.swift
//  BGSoftTask
//
//  Created by Valera Sysov on 16.02.22.
//

import UIKit

protocol PhotoViewLinkDelegate: AnyObject {
    func openInformationViewController(link: String)
}

final class PhotoViewCell: UICollectionViewCell{
    
    static let identifier = "PhotoCell"
    
    weak var delegat: PhotoViewLinkDelegate?
    
    lazy var imageView = UIImageView()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.shadowColor = .darkGray
        label.shadowOffset = CGSize(width: 3.0, height: 2.0)
        label.textColor = .white
        label.font = .systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(.lightGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var photoButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(.lightGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var userLink: String? {
        willSet {
            userButton.setTitle(newValue, for: .normal)
        }
    }
    var photoLink: String? {
        willSet {
            photoButton.setTitle(newValue, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpImageView()
        setUpUserButton()
        setUpPhotoButton()
        setUpView()
        constraints()
    }
    
    @objc private func setPhoto(_ notification: Notification) {
        print("Notification is receive")
        guard let notification = notification.object as? UIImage else { return }
        self.imageView.image = notification
        
    }
    private func setUpUserButton() {
        userButton.addTarget(self, action: #selector(userLink(_:)), for: .touchUpInside)
    }
    private func setUpPhotoButton() {
        photoButton.addTarget(self, action: #selector(photoLink(_:)), for: .touchUpInside)
    }
    
    @objc private func userLink(_ button: UIButton) {
        guard let userLink = userLink else { return }
        delegat?.openInformationViewController(link: userLink)
    }
    
    @objc private func photoLink(_ button: UIButton) {
        guard let photoLink = photoLink else { return }
        delegat?.openInformationViewController(link: photoLink)
    }
    
    private func loadImages(imageUrl: String) {
        guard let url = URL(string: imageUrl)  else { return }
        if let image = NetworkingManager.imageCashe.object(forKey: imageUrl as NSString) as? UIImage {
            self.imageView.image = image
            return
        }
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.async { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    guard let image = image else {return}
                    NetworkingManager.imageCashe.setObject(image, forKey: imageUrl as NSString)
                    self?.imageView.image = image
                }
            } catch {
                print(error)
            }
        }
    }
    
    func setObject(object: Photos) {
        loadImages(imageUrl: object.imageURL)
    }
    private func setUpView() {
        addSubview(imageView)
        addSubview(authorLabel)
        addSubview(userButton)
        addSubview(photoButton)
    }
    
    private func setUpImageView() {
        imageView = UIImageView(frame: self.bounds)
        imageView.contentMode = .scaleAspectFill
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoViewCell {
    func constraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            authorLabel.bottomAnchor.constraint(equalTo: userButton.bottomAnchor,constant: -50),
            
            userButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            userButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            userButton.bottomAnchor.constraint(equalTo: photoButton.bottomAnchor, constant: -20),

            photoButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            photoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            photoButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
}
