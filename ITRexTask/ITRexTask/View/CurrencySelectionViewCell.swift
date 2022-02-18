//
//  CurrencySelectionViewCell.swift
//  ITRexTask
//
//  Created by Valera Sysov on 18.02.22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BYN")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "BYN"
        label.backgroundColor = .systemBackground
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(imageView)
        contentView.addSubview(currencyLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        currencyLabel.frame = CGRect(x: 5, y: contentView.frame.size.height - 55, width: contentView.frame.size.width - 10, height: 50)
        
        imageView.frame = CGRect(x: 5, y: 5, width: contentView.frame.size.width - 10, height: contentView.frame.size.height - currencyLabel.frame.size.height - 10)
    }
    
    public func configure(label: String, image: String) {
        currencyLabel.text = label
        imageView.image = UIImage(named: image)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        currencyLabel.text = nil
        imageView.image = nil
        
    }
    
}

