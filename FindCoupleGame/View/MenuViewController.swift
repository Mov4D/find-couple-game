//
//  MenuViewController.swift
//  FindCoupleGame
//
//  Created by Vadim Aleshin on 15.02.2022.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        buttonStartGame.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    private let backgroundImage: UIImageView = makeImageView()
    private let buttonStartGame: UIButton = makeButtonStartGame()
    private let viewController = FindCoupleViewController()
    
    private func setupUI() {
        title = "Find couple"
        view.backgroundColor = UIColor(red: 9/255, green: 50/255, blue: 20/255, alpha: 1)
        
        view.addSubview(backgroundImage)
        view.addSubview(buttonStartGame)
        
        buttonStartGame.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonStartGame.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonStartGame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            backgroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension MenuViewController {
    private static func makeButtonStartGame() -> UIButton {
        let button = UIButton()
        button.setTitle("Start Game", for: .normal)
        return button
    }
    
    private static func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "poker-table-background")
        return imageView
    }
}
