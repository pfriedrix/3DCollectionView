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
            cardsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -100),
            cardsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 100),
            cardsView.heightAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cardsView.scrollToCenter()
    }
}

