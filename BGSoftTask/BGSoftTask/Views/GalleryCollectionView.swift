//
//  GalleryCollectionView.swift
//  BGSoftTask
//
//  Created by Valera Sysov on 16.02.22.
//

import UIKit

final class GalleryCollectionView: UICollectionView {
    
    let layout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: self.layout)
        setupCollectionView()
    }
    private func setupLayout() {
        let width = self.bounds.width
        let height = self.bounds.height
        let sideInset: CGFloat = 25
        let cellWidth = width - (sideInset * 2)
        let cellHeight = height
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = sideInset * 2
        layout.sectionInset = UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
    private func setupCollectionView() {
        self.collectionViewLayout = layout
        self.isPagingEnabled = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
