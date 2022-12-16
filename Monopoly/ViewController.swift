//
//  ViewController.swift
//  Monopoly
//
//  Created by Pfriedrix on 15.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let cardsView = CardsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(cardsView)
        view.addConstraints([
            cardsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardsView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cardsView.scrollToCenter()
    }
}
