//
//  CardCollectionViewCell.swift
//  FindCoupleGame
//
//  Created by Vadim Aleshin on 12.02.2022.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var card: CardModel? {
        get { self.cardData }
        set { self.cardData = newValue }
    }
    let reuseID = "cardCell"
    
    private let cardView = CardGameView()
    private var imageCard: [UIImage] = []
    private var cardData: CardModel? {
        didSet {
            guard let imageArray = cardData?.imageCard else { return }
            imageCard = imageArray
            cardView.image = imageCard.first
        }
    }
    
    private func setupView() {
        self.contentView.addSubview(cardView)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            cardView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            cardView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            cardView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
    
    func rotationCard() {
        let degreeStart: Double = 180
        let degreeMiddle: Double = 90
        let rotationAngleMiddle = CGFloat(degreeStart * Double.pi / 180)
        let rotationAngleEnd = CGFloat(degreeMiddle * Double.pi / 180)
        let rotationTransformStart = CATransform3DMakeRotation(rotationAngleMiddle, 0, 1, 0)
        let rotationTransformMiddle = CATransform3DMakeRotation(rotationAngleEnd, 0, 1, 0)
        
        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveEaseOut) {
            self.layer.transform = rotationTransformMiddle
        } completion: { _ in
            self.cardView.image = self.imageCard.last
            self.cardView.layer.transform = rotationTransformStart
            let image = self.imageCard[0]
            self.imageCard[0] = self.imageCard[1]
            self.imageCard[1] = image
            
            UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveEaseOut) {
                self.layer.transform = rotationTransformStart
            }
        }
        
    }
}
