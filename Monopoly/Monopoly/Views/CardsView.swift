//
//  CardsView.swift
//  Monopoly
//
//  Created by Pfriedrix on 15.12.2022.
//

import UIKit

class CardsView: UICollectionView {
    
    private let itemsOnDisplay = 7.0
    private let itemWidthSize = 120.0
    
    private let realSize = 10
    
    var currIndex = 0
    
    let len = 1001
    
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5.0
        return layout
    }()
    
    init () {
        super.init(frame: .zero, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        register(CardCell.self, forCellWithReuseIdentifier: "card")
        
        delegate = self
        dataSource = self
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(tap))
        doubleTap.numberOfTapsRequired = 2

        addGestureRecognizer(doubleTap)
        
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 500
        transform = CATransform3DRotate(transform, .pi / 4, 1, 0, 0)
        
        layer.transform = transform
    }
    
    func scrollToCenter() {
        scrollToItem(at: IndexPath(item: len / 2, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc
    private func tap() {
        scrollToCenter()
    }
}

extension CardsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        len // 1001
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CardCell.dequeue(from: collectionView, at: indexPath)
        let realIndex = indexPath.item % realSize
        cell.coordinatesLabel(realIndex).text = "\(realIndex)"
//        print(indexPath, getCloseItemToCenter())
        return cell
    }
}

extension CardsView: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let centerItem = getCloseItemToCenter()
        let safeIndex = min(centerItem.item + 1, self.len - 1)
        scrollToItem(at: IndexPath(item: safeIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let centerItem = getCloseItemToCenter()
        let safeIndex = min(centerItem.item + 1, self.len - 1)
        scrollToItem(at: IndexPath(item: safeIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    private func getCloseItemToCenter() -> IndexPath {
        let index = Int(contentOffset.x / (itemWidthSize + layout.minimumLineSpacing)) + 3
        return IndexPath(item: index, section: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("scroll", scrollView.contentOffset)
        
        let new = getCloseItemToCenter().item
        if new == currIndex {
            print("is here")
        } else {
            print("out there")
            
            print(currIndex, new)
            let prev = CardCell.dequeue(from: self, at: IndexPath(item: currIndex, section: 0))
            let curr = CardCell.dequeue(from: self, at: IndexPath(item: new, section: 0))
            prev.restore()
            curr.animateCell()
            currIndex = new
        }
        
    }
}

extension CardsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = itemWidthSize
        return CGSize(width: width, height: height)
    }
}
