//
//  Card.swift
//  Monopoly
//
//  Created by Pfriedrix on 15.12.2022.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    static let identifier = "card"
    static func register(with collectionView: UICollectionView) {
        collectionView.register(self, forCellWithReuseIdentifier: identifier)
    }
    
    static func dequeue(from collectionView: UICollectionView, at indexPath: IndexPath) -> CardCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        as? CardCell ?? CardCell()
        
        return cell
    }
    
    func coordinatesLabel(_ index: Int) -> UILabel {
        if let label = contentView.subviews.first as? UILabel {
            return label
        }
        
        let label = UILabel(frame: contentView.bounds)
        label.font = UIFont.systemFont(ofSize: 24.0)
        label.textColor = .white
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        label.translatesAutoresizingMaskIntoConstraints = true
        
        let imageView = UIImageView(frame: contentView.frame)
        imageView.image = UIImage(named: "cat-\(index)")
        imageView.contentMode = .redraw
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.zPosition = 1
        
        contentView.addSubview(label)
        contentView.addSubview(imageView)
        contentView.layer.shadowColor = UIColor.red.cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = .init(width: 0, height: 7)
        contentView.layer.shadowRadius = 7
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.backgroundColor = .red
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale
        contentView.transform3D = CATransform3DRotate(contentView.transform3D, .pi / 3, 1, 0, 0)
        
        return label
    }
}
