//
//  FoodFork.swift
//  food2fork
//
//  Created by Dany Tixador on 27/07/2019.
//  Copyright © 2019 Dany Tixador. All rights reserved.
//

import Foundation

// MARK: - FoodFork
struct FoodFork: Codable {
    let count: Int
    let recipes: [Recipe]
}

// MARK: - Recipe
struct Recipe: Codable {
    let publisher: String
    let f2FURL: String
    let title: String
    let sourceURL: String
    let recipeID: String
    let imageURL: String
    let socialRank: Double
    let publisherURL: String
    
    enum CodingKeys: String, CodingKey {
        case publisher = "publisher"
        case f2FURL = "f2f_url"
        case title = "title"
        case sourceURL = "source_url"
        case recipeID = "recipe_id"
        case imageURL = "image_url"
        case socialRank = "social_rank"
        case publisherURL = "publisher_url"
    }
}
