//
//  Food2ForkWs.swift
//  food2fork
//
//  Created by Dany Tixador on 27/07/2019.
//  Copyright © 2019 Dany Tixador. All rights reserved.
//

import Foundation
import Alamofire

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
                        print(food.count)
                    }
                case .failure:
                    completion(nil)
                    print("error search food")
                }
        }
        
    }
    
}
