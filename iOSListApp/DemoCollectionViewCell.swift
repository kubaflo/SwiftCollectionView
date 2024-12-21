//
//  DemoCollectionViewCell.swift
//  iOSListApp
//
//  Created by Jakub Florkowski on 21/12/2024.
//

import UIKit

class DemoCollectionViewCell: UICollectionViewCell {
    static let identifier = "DemoCollectionViewCell"
    
    private lazy var container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.contentMode = .scaleAspectFit;
        return imageView
    }()
    
    private lazy var label : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center;
        label.translatesAutoresizingMaskIntoConstraints = false;
        return label;
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
        label.text = imageName
        imageView.image = UIImage(systemName: imageName)
    }
    
    private func setupView()
    {
        container.addSubview(imageView)
        container.addSubview(label)
        contentView.addSubview(container)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
