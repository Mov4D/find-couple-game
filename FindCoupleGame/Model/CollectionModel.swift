//
//  CollectionModel.swift
//  FindCoupleGame
//
//  Created by Vadim Aleshin on 12.02.2022.
//

import Foundation
import UIKit

enum CellType {
  case cardCell
}

protocol Configurator {
  // переменная для ячейки с reuse id
    var reuseId: String { get }
  // тип ячейки для последующей отработки нажатия на ячейку
  var cellType: CellType { get }
  // настройка ячейки
    func setupCell(_ cell: UIView)
}

struct cardResponseModel {
  let cardResponse: [CardModel]
}

struct CardModel {
    let cardID: String
    let imageCard: [UIImage]?
    var faceUp: Bool
}
