//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Valera Sysov on 1.03.22.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    var onFavButtonTapped: (() -> ())?
    
    override func prepareForReuse() {
        newsImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsImageView.layer.cornerRadius = 20
        favButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        favButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    
    @IBAction func favButton(_ sender: UIButton) {
        favButton.isSelected.toggle()
        onFavButtonTapped?()
    }
}
