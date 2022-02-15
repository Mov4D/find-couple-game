//
//  CardGame.swift
//  FindCoupleGame
//
//  Created by Vadim Aleshin on 12.02.2022.
//

import UIKit

class CardGameView: UIView {
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var image: UIImage? {
        willSet { pictureView.image = newValue }
        didSet {
            if image == nil {
                pictureView.isHidden = true
            }
        }
    }
    
    private let pictureView: UIImageView = makeImageView()

    private func setupView() {
        self.layer.cornerRadius = 4.8
        pictureView.layer.borderWidth = 1
        pictureView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        pictureView.layer.cornerRadius = 4.8
        pictureView.layer.masksToBounds = true
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        self.addSubview(pictureView)
        
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pictureView.topAnchor.constraint(equalTo: self.topAnchor),
            pictureView.leftAnchor.constraint(equalTo: self.leftAnchor),
            pictureView.rightAnchor.constraint(equalTo: self.rightAnchor),
            pictureView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

extension CardGameView {
    private static func makeImageView() -> UIImageView {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }
}
