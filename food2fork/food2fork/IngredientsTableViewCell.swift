//
//  IngredientsTableViewCell.swift
//  food2fork
//
//  Created by Dany Tixador on 28/07/2019.
//  Copyright © 2019 Dany Tixador. All rights reserved.
//

import UIKit
import Reusable

class IngredientsTableViewCell: UITableViewCell, NibReusable {

    // MARK: - IBOutlet
    @IBOutlet private weak var ingredientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

}

// MARK: - Configure setup
extension IngredientsTableViewCell {
    
    private func setup() {
        ingredientLabel.applyDefaultSetup()
    }
}

// MARK: - Prepare Cell
extension IngredientsTableViewCell {
    func prepare(with ingredient: String) {
        ingredientLabel.text = "\(ingredient)"
    }
}
