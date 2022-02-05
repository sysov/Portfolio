//
//  Header.swift
//  XOneTask
//
//  Created by Valera Sysov on 1.02.22.
//

import UIKit

final class Header: View {
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let label: UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setup() {
        addSubview(imageView)
        addSubview(label)
        setUpImage()
        setUpLabel()
    }
    
    private func setUpImage() {
        self.makeCenter(subview: imageView)
        imageView.contentMode = .redraw
        imageView.image = R.image.headerBackground()
    }
    
    private func setUpLabel() {
        self.makeCenter(subview: label)
        label.contentMode = .redraw
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineHeightMultiple = 0.88
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.129, green: 0.126, blue: 0.125, alpha: 1),
            NSAttributedString.Key.font: R.font.oswaldLight(size: 45), .paragraphStyle: paragraphStyle
        ]
        label.attributedText = NSAttributedString(string: "локации", attributes: attributes as [NSAttributedString.Key : Any])
    }
}
