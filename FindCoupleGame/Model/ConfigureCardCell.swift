//
//  ConfigureCardCell.swift
//  FindCoupleGame
//
//  Created by Vadim Aleshin on 13.02.2022.
//

import Foundation
import UIKit

class ConfigureCardCell {
    
    init(count: Int) {
        self.arrayName = generateRandomNameImageArray(nameArray: generateNameImageArray(count: count))
    }
    
    private var arrayName: [String] = []
    
    func configureCardCell(collection: UICollectionView, indexPath: IndexPath) -> CardCollectionViewCell? {
        guard let cell = collection.dequeueReusableCell(
            withReuseIdentifier: CardCollectionViewCell().reuseID,
            for: indexPath
        ) as? CardCollectionViewCell else { return nil }
        
        cell.card = .init(
            cardID: arrayName[indexPath.row],
            imageCard: [
                CardImage.cardСover[5]!,
                UIImage(named: arrayName[indexPath.row]) ?? UIImage()
            ],
            faceUp: false
        )
        return cell
    }
    
    private func generateNameImageArray(count: Int) -> [String] {
        var imageNameSet: Set<String> = []
        
        while imageNameSet.count != count / 2 {
            imageNameSet.insert(CardImage.cardFace[Int.random(in: 0..<CardImage.cardFace.count)])
        }
        return Array(imageNameSet)
    }
    
    private func generateRandomNameImageArray(nameArray: [String]) -> [String] {
        var randomArray: [String] = nameArray + nameArray
        let countRange = 0..<randomArray.count
        
        for i in countRange {
            let j = Int.random(in: countRange)
            let help = randomArray[j]
            randomArray[j] = randomArray[i]
            randomArray[i] = help
        }
        return randomArray
    }
}

// MARK: - CardImage

extension ConfigureCardCell {
    private struct CardImage {
        static let cardFace = [
            "Atlas_deck_2_of_clubs.svg",
            "Atlas_deck_2_of_diamonds.svg",
            "Atlas_deck_2_of_hearts.svg",
            "Atlas_deck_2_of_spades.svg",
            
            "Atlas_deck_3_of_clubs.svg",
            "Atlas_deck_3_of_diamonds.svg",
            "Atlas_deck_3_of_hearts.svg",
            "Atlas_deck_3_of_spades.svg",
            
            "Atlas_deck_4_of_clubs.svg",
            "Atlas_deck_4_of_diamonds.svg",
            "Atlas_deck_4_of_hearts.svg",
            "Atlas_deck_4_of_spades.svg",
            
            "Atlas_deck_5_of_clubs.svg",
            "Atlas_deck_5_of_diamonds.svg",
            "Atlas_deck_5_of_hearts.svg",
            "Atlas_deck_5_of_spades.svg",
            
            "Atlas_deck_6_of_clubs.svg",
            "Atlas_deck_6_of_diamonds.svg",
            "Atlas_deck_6_of_hearts.svg",
            "Atlas_deck_6_of_spades.svg",
            
            "Atlas_deck_7_of_clubs.svg",
            "Atlas_deck_7_of_diamonds.svg",
            "Atlas_deck_7_of_hearts.svg",
            "Atlas_deck_7_of_spades.svg",
            
            "Atlas_deck_8_of_clubs.svg",
            "Atlas_deck_8_of_diamonds.svg",
            "Atlas_deck_8_of_hearts.svg",
            "Atlas_deck_8_of_spades.svg",
            
            "Atlas_deck_9_of_clubs.svg",
            "Atlas_deck_9_of_diamonds.svg",
            "Atlas_deck_9_of_hearts.svg",
            "Atlas_deck_9_of_spades.svg",
            
            "Atlas_deck_ace_of_clubs.svg",
            "Atlas_deck_ace_of_diamonds.svg",
            "Atlas_deck_ace_of_hearts.svg",
            "Atlas_deck_ace_of_spades.svg",
            
            "Atlas_deck_king_of_clubs.svg",
            "Atlas_deck_king_of_diamonds.svg",
            "Atlas_deck_king_of_hearts.svg",
            "Atlas_deck_king_of_spades.svg",
            
            "Atlas_deck_jack_of_clubs.svg",
            "Atlas_deck_jack_of_diamonds.svg",
            "Atlas_deck_jack_of_hearts.svg",
            "Atlas_deck_jack_of_spades.svg",
            
            "Atlas_deck_queen_of_clubs.svg",
            "Atlas_deck_queen_of_diamonds.svg",
            "Atlas_deck_queen_of_hearts.svg",
            "Atlas_deck_queen_of_spades.svg",
        ]
        
        static let cardСover = [
            UIImage(named: "Atlas_deck_card_back_blue_and_brown.svg"),
            UIImage(named: "Atlas_deck_card_back_green_and_dark_red.svg"),
            UIImage(named: "card_back_black"),
            UIImage(named: "card_back_blue"),
            UIImage(named: "card_back_green"),
            UIImage(named: "card_back_orange"),
            UIImage(named: "card_back_purple"),
            UIImage(named: "card_back_red"),
        ]
    }
}
