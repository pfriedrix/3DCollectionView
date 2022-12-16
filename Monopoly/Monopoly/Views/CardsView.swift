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
    
    var indexOffset = 0
    
    private var lastCenterItemIndex = 0
    
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
        decelerationRate = .fast
        
        delegate = self
        dataSource = self
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(tap))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
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
        len
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CardCell.dequeue(from: collectionView, at: indexPath)
        let realIndex = indexPath.item % 10
        cell.coordinatesLabel(realIndex).text = "\(realIndex)"
        return cell
    }
}

extension CardsView: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        let centerItem = getCloseItemToCenter()
        scrollToItem(at: centerItem, at: .centeredHorizontally, animated: true)
    }

    private func getCloseItemToCenter() -> IndexPath {
        let index = Int(contentOffset.x / (itemWidthSize + layout.minimumLineSpacing)) + 3
        return IndexPath(item: index, section: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension CardsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = itemWidthSize
        return CGSize(width: width, height: height)
    }
}
