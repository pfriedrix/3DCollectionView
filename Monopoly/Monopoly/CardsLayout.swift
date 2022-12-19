//
//  CardsLayout.swift
//  Monopoly
//
//  Created by Pfriedrix on 19.12.2022.
//

import UIKit


class CardsLayout: UICollectionViewFlowLayout {
    override init () {
        super.init()
        scrollDirection = .horizontal
        minimumLineSpacing = 7.0
    }
    
    private var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        layoutAttributes = []
        let superLayoutAttributes = super.layoutAttributesForElements(in: rect)!
        
        let collectionViewCenterX = collectionView!.bounds.width * 0.5
        
        superLayoutAttributes.forEach { (attributes) in
            
            let copyLayout = attributes.copy() as! UICollectionViewLayoutAttributes
            
            let deltaX = abs(collectionViewCenterX - ((copyLayout.center.x - 50) - collectionView!.contentOffset.x))
            if deltaX < copyLayout.bounds.width / 2 {
                let x = deltaX / copyLayout.bounds.width
                let diff = (0.5 - x)
                var tranform = CATransform3DMakeTranslation(0, diff >= 0.01 && diff < 0.1 ? 7 * diff * 10 : 7, -30)
                tranform.m34 = -1.0 / 500
                copyLayout.transform = CATransform3DGetAffineTransform(tranform)
                
            }
            
            layoutAttributes.append(copyLayout)
        }
        return layoutAttributes
    }
}
