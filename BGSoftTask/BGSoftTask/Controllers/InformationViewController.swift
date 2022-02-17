//
//  InformationViewController.swift
//  BGSoftTask
//
//  Created by Valera Sysov on 17.02.22.
//

import UIKit
import WebKit

final class InformationViewController: UIViewController {
    
    let web = WKWebView()
    var link: String?
    private func setUpWeb() {
        web.frame = view.bounds
        view.addSubview(web)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWeb()
        
        guard let link = link else { return }
        guard let url = URL(string: link) else { return }
        let request = URLRequest(url: url)
        web.load(request)
    }
}
