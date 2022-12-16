//
//  UICollectionViewFlowLaout+centerDisplacement.swift
//  Monopoly
//
//  Created by Pfriedrix on 15.12.2022.
//

import UIKit


//extension UICollectionViewFlowLayout {
//    func centerDisplacement() -> CGPoint {
//        guard let collectionView = collectionView else { return .zero }
//        let contentOffset = collectionView.contentOffset
//        let visibleSize = collectionView.frame.size
//        return CGPoint(x: contentOffset.x - (collectionViewContentSize.width - visibleSize.width) * 0.5,
//                       y: contentOffset.y - (collectionViewContentSize.height - visibleSize.height) * 0.5)
//    }
//
//    func roundToTiles(distance: CGPoint, rounding roudingRule: FloatingPointRoundingRule) -> CGPoint {
//        return CGPoint(x: (distance.x / itemSize.width).rounded(roudingRule),
//                       y: (distance.y / itemSize.height).rounded(roudingRule))
//    }
//}
