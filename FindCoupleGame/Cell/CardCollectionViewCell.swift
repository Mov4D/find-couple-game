//
//  CardCollectionViewCell.swift
//  FindCoupleGame
//
//  Created by Vadim Aleshin on 12.02.2022.
//

import UIKit

protocol CardCollectionViewCellDelegate: AnyObject {
    func cellRotation(_ cardCollectionViewCell: CardCollectionViewCell)
    func delleteCard(_ cardCollectionViewCell: CardCollectionViewCell)
}

class CardCollectionViewCell: UICollectionViewCell {
    weak var delegate: CardCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var card: CardModel? {
        get { self.cardData }
        set { self.cardData = newValue; faceUp = newValue?.faceUp }
    }
    
    var faceUp: Bool? {
        didSet {
            //print(faceUp)
        }
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
        self.layer.removeAllAnimations()
        guard let options = [
            UIView.AnimationOptions.transitionFlipFromLeft,
            UIView.AnimationOptions.transitionFlipFromRight,
            UIView.AnimationOptions.transitionFlipFromBottom,
            UIView.AnimationOptions.transitionFlipFromTop
        ].randomElement() else { return }
        
        UIView.transition(
            with: cardView,
            duration: 0.4,
            options: [.curveEaseOut, options],
            animations: {
                self.cardView.image = self.imageCard.last
                let image = self.imageCard[0]
                self.imageCard[0] = self.imageCard[1]
                self.imageCard[1] = image
            },
            completion: { [self] _ in
                self.faceUp = !(faceUp ?? false)
                self.delegate?.cellRotation(self)
            }
        )
    }
    
    func deleteCard() {
        self.layer.removeAllAnimations()
        self.faceUp = false
        UIView.transition(
            with: cardView,
            duration: 1,
            options: [.curveEaseOut, .transitionCurlUp],
            animations: {
                self.cardView.image = nil
            },
            completion: { [self] _ in
                self.isHidden = true
                self.delegate?.delleteCard(self)
            }
        )
    }
    
}
