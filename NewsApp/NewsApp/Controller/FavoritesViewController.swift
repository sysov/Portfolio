//
//  FavoritesViewController.swift
//  NewsApp
//
//  Created by Valera Sysov on 11.03.22.
//

import UIKit
import Kingfisher
import SafariServices

final class FavoritesViewController: UIViewController {
    let articleManager: PersistenceProtocol = UserDefaultsManager()
    lazy var articles:[Article] = {
        articleManager.readFavorites()
    }()
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        articles =  articleManager.readFavorites()
        favoritesTableView.reloadData()
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as? NewsTableViewCell else { return UITableViewCell() }
        let article = articles[indexPath.row]
        cell.newsTitleLabel.text = article.title
        cell.newsDescriptionLabel.text = article.description
        let placeholderImage = UIImage(named: "placeholder")
        let processor = DownsamplingImageProcessor(size: cell.newsImageView.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 20)
        cell.newsImageView.kf.indicatorType = .activity
        if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
            cell.newsImageView.kf.setImage(
                with: url,
                placeholder: placeholderImage,
                options: [
                    .processor(processor),
                    .loadDiskFileSynchronously,
                    .cacheOriginalImage,
                    .transition(.fade(0.25)),
                ],
                progressBlock: { receivedSize, totalSize in
                },
                completionHandler: { result in
                }
            )
        } else {
            cell.newsImageView.image = placeholderImage
        }
        return cell
    }
}
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        guard let url = URL(string: article.url) else { return }
        let browserViewController = SFSafariViewController(url: url)
        present(browserViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        let art = articles[indexPath.row]
        
        if editingStyle == .delete {
            articles.remove(at: indexPath.row)
            favoritesTableView.reloadData()
            
        }
}
}
