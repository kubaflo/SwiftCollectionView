//
//  DemoCollectionViewCell.swift
//  iOSListApp
//
//  Created by Jakub Florkowski on 21/12/2024.
//

import UIKit

class DemoCollectionViewCell: UICollectionViewCell {
    static let identifier = "DemoCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.contentMode = .scaleAspectFit;
        return imageView
    }()
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          setupView()
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    func configure(with imageName: String)
    {
        imageView.image = UIImage(systemName: imageName)
    }
    
    private func setupView()
    {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
