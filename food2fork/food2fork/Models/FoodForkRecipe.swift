//
//  foodForkRecipe.swift
//  food2fork
//
//  Created by Dany Tixador on 28/07/2019.
//  Copyright © 2019 Dany Tixador. All rights reserved.
//

import Foundation

// MARK: - FoodForkRecipe

// MARK: - Food2Fork
struct FoodForkRecipe: Codable, Equatable {
    let recipe: RecipeFood
}

// MARK: - Recipe
struct RecipeFood: Codable, Equatable {
    let publisher: String
    let f2FURL: String
    let ingredients: [String]
    let sourceURL: String
    let recipeID: String
    let imageURL: String
    let socialRank: Int
    let publisherURL: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case publisher
        case f2FURL = "f2f_url"
        case ingredients
        case sourceURL = "source_url"
        case recipeID = "recipe_id"
        case imageURL = "image_url"
        case socialRank = "social_rank"
        case publisherURL = "publisher_url"
        case title
    }
}
