//
//  CollectionViewCell.swift
//  hw3
//
//  Created by Berksu Kısmet on 6.10.2022.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    // MARK: - define computed properties
    var image: UIImage? {
        didSet{
            imageView.image = image
        }
    }
    
    var title: String? {
        didSet{
            titleLabel.text = title
        }
    }
    
    // -MARK: Add gradient layer
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        layer.locations = [0.0, 1.0]
        return layer
    }()
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add imageView and add constraints to imageView
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        // Add titleLabel and add constraints to titleLabel
        imageView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0)
        ])
        
        imageView.layer.insertSublayer(gradientLayer, at: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
