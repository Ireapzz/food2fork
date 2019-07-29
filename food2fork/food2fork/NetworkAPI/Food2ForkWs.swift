//
//  Food2ForkWs.swift
//  food2fork
//
//  Created by Dany Tixador on 27/07/2019.
//  Copyright © 2019 Dany Tixador. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

final class Food2ForkWs {
    
    func searchFood(with query: String, completion: @escaping (FoodFork?) -> Void) {
        
        let searchParams: Parameters = [
            "key": Constants.apiKey,
            "q": "\(query)"
        ]
     
        Alamofire.request(Constants.searchFoodUrl,
                          parameters: searchParams)
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let jsonData = response.data {
                        guard let food = try? JSONDecoder().decode(FoodFork.self, from: jsonData) else {
                            completion(nil)
                            return
                        }
                        completion(food)
                    }
                case .failure:
                    completion(nil)
                    print("error search food")
                }
        }
        
    }
    
    func getFoodRecipe(with rId: String, completion: @escaping (FoodForkRecipe?) -> Void) {
        
        let getFoodParams: Parameters = [
            "key": Constants.apiKey,
            "rId": "\(rId)"
        ]
        
        
        Alamofire.request(Constants.getFoodUrl,
                          parameters: getFoodParams)
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let jsonData = response.data {
                        guard let foodDetail = try? JSONDecoder().decode(FoodForkRecipe.self, from: jsonData) else {
                            completion(nil)
                            return
                        }
                        completion(foodDetail)
                    }
                case .failure:
                    completion(nil)
                    print("error get food")
                }
        }
        
    }
    
    static func downloadImageFromUrl(_ sourceUrl: URL, responseHandler: @escaping (UIImage?) -> Void) {
        
        Alamofire.request(sourceUrl)
            .responseImage { response in
                if let downloadedImage = response.result.value {
                    responseHandler(downloadedImage)
                } else {
                    responseHandler(nil)
                }
        }
    }
    
}
