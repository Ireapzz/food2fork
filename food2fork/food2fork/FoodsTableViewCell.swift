//
//  FoodsTableViewCell.swift
//  food2fork
//
//  Created by Dany Tixador on 27/07/2019.
//  Copyright © 2019 Dany Tixador. All rights reserved.
//

import UIKit
import Reusable

class FoodsTableViewCell: UITableViewCell, NibReusable {

    // MARK: - IBOutlet
    @IBOutlet weak var foodImg: UIImageView!
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var foodPublisher: UILabel!
    @IBOutlet weak var foodRank: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
}

// MARK: - Configure setup
extension FoodsTableViewCell {
    
    private func setup() {
        foodTitle.applyDefaultSetup()
        foodPublisher.applyDefaultSetup()
        foodRank.applyDefaultSetup()
    }
}

// MARK: - Prepare Cell
extension FoodsTableViewCell {
    func prepare(with news: Recipe) {
        foodTitle.text = "\(news.title)"
        foodPublisher.text = "\(news.publisher)"
        foodRank.text = "\(news.socialRank)"
    }
}

