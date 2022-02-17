//
//  GalleryViewController+Extensions.swift
//  BGSoftTask
//
//  Created by Valera Sysov on 17.02.22.
//

import UIKit

extension GalleryViewController: PhotoViewLinkDelegate {
    func openInformationViewController(link: String) {
        let vc = InformationViewController()
        vc.link = link
        present(vc, animated: true, completion: nil)
    }
}
