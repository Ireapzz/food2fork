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
    @IBOutlet private weak var foodImg: UIImageView!
    @IBOutlet private weak var foodTitle: UILabel!
    @IBOutlet private weak var foodPublisher: UILabel!
    @IBOutlet private weak var foodRank: UILabel!
    
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
    func prepare(with food: Recipe) {
        foodTitle.text = "\(food.title)"
        foodPublisher.text = "\(food.publisher)"
        foodRank.text = "\(food.socialRank)"
        downloadPlayerImage(url: food.imageURL)
    }
    
    private func downloadPlayerImage(url: String) {
        guard let imgUrl = URL(string: url) else { return }
        Food2ForkWs.downloadImageFromUrl(imgUrl) { (downloadedImage) in
            self.foodImg.image = downloadedImage
        }
    }
}

