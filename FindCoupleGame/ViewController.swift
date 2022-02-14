//
//  ViewController.swift
//  FindCoupleGame
//
//  Created by Vadim Aleshin on 12.02.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        cardCollection.backgroundColor = .systemGreen
        
        title = "Find couple"
        
        cardCollection.delegate = self
        cardCollection.dataSource = self
        cardCollection.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell().reuseID)
        addToScreen()
        setConstraints()
        
    }
    
    private let cardCollection: UICollectionView = makeCardCollection()
    private let configureCard = ConfigureCardCell(count: 20)
    private var canRotation = true
    
}

extension ViewController {
    private func addToScreen() {
        view.addSubview(cardCollection)
    }
    
    private func setConstraints() {
        cardCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cardCollection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            cardCollection.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            cardCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = configureCard.configureCardCell(collection: collectionView, indexPath: indexPath) else { return UICollectionViewCell() }
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        (collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell).rotationCard()
    }
}

extension ViewController: CardCollectionViewCellDelegate {
    func cellRotation(_ cardCollectionViewCell: CardCollectionViewCell) {
        guard let arrayVisible = (self.cardCollection.visibleCells as? [CardCollectionViewCell]) else { return }
        
        let arrayVisibleFaceUp = arrayVisible.filter { $0.faceUp == true }
        
        if arrayVisibleFaceUp.count == 2 {
            if arrayVisibleFaceUp.first?.card?.cardID == arrayVisibleFaceUp.last?.card?.cardID {
                arrayVisibleFaceUp.forEach { $0.isHidden = true }
                arrayVisibleFaceUp.forEach { $0.rotationCard() }
            }
            _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                arrayVisibleFaceUp.forEach { $0.rotationCard() }
            }
        }
    }
    
    
}

extension ViewController {
    private static func makeCardCollection() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 64 * 1.25, height: 96 * 1.25)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collection
    }
}
