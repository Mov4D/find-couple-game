//
//  FindCoupleViewController.swift
//  FindCoupleGame
//
//  Created by Vadim Aleshin on 12.02.2022.
//

import UIKit

class FindCoupleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardCollection.delegate = self
        cardCollection.dataSource = self
        cardCollection.register(
            CardCollectionViewCell.self,
            forCellWithReuseIdentifier: CardCollectionViewCell().reuseID
        )
        
        setupUI()
        
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.time += 1
        }
    }
    
    private let timeLabel: UILabel = makeTimeLabel()
    private let cardCollection: UICollectionView = makeCardCollection()
    private let configureCard = ConfigureCardCell(count: 20)
    private var canRotation = true
    private var countTap: Int = 0
    private var time: Int = 0
    private var counter: Int = 0
}

// MARK: - Setup UI

extension FindCoupleViewController {
    private func setupUI() {
        view.backgroundColor = .systemGreen
        cardCollection.backgroundColor = .systemGreen
        
        title = "Find couple"
        
        view.addSubview(cardCollection)
        view.addSubview(timeLabel)
        
        cardCollection.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cardCollection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            cardCollection.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            cardCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: - UICollectionView

extension FindCoupleViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = configureCard.configureCardCell(collection: collectionView, indexPath: indexPath) else { return UICollectionViewCell() }
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell else { return }
        
        if self.countTap < 2 && cell.faceUp == false {
            cell.rotationCard()
            self.countTap += 1
        }
    }
}

// MARK: - CardCollectionViewCellDelegate

extension FindCoupleViewController: CardCollectionViewCellDelegate {
    func delleteCard(_ cardCollectionViewCell: CardCollectionViewCell) {
        self.countTap = 0
        self.counter += 1
        if 20 == self.counter {
            timeLabel.text = String(time)
            timeLabel.isHidden = false
        }
    }
    
    func cellRotation(_ cardCollectionViewCell: CardCollectionViewCell) {
        guard let arrayVisible = (self.cardCollection.visibleCells as? [CardCollectionViewCell])
        else { return }
        
        let arrayVisibleFaceUp = arrayVisible.filter { $0.faceUp == true }
        
        if arrayVisibleFaceUp.count == 2 {
            if arrayVisibleFaceUp.first?.card?.cardID == arrayVisibleFaceUp.last?.card?.cardID {
                arrayVisibleFaceUp.forEach { $0.deleteCard() }
            } else {
                _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                    arrayVisibleFaceUp.forEach { $0.rotationCard() }
                    self.countTap = 0
                }
            }
        }
    }
}

// MARK: - Factory

extension FindCoupleViewController {
    private static func makeCardCollection() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 64 * 1.25, height: 96 * 1.25)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collection
    }
    
    private static func makeTimeLabel() -> UILabel {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 40)
        label.isHidden = true
        return label
    }
}
