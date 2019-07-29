//
//  FoodDetailsViewController.swift
//  food2fork
//
//  Created by Dany Tixador on 28/07/2019.
//  Copyright © 2019 Dany Tixador. All rights reserved.
//

import UIKit

class FoodDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var foodImageView: UIImageView!
    @IBOutlet private weak var foodTitle: UILabel!
    @IBOutlet private weak var foodPublisher: UILabel!
    @IBOutlet private weak var foodRank: UILabel!
    @IBOutlet private weak var foodSource: UILabel!
    @IBOutlet private weak var IngredientsTableView: UITableView!
    
    var model: Recipe!
    private var ingredients: [String]? {
        didSet {
            self.IngredientsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let callApi = Food2ForkWs()
        callApi.getFoodRecipe(with: model.recipeID) { foodDetail in
            guard let food = foodDetail else { return }
            self.ingredients = food.recipe.ingredients
        }
        
        setup()
    }
    
}

// MARK: - Configuration Setup
extension FoodDetailsViewController {
    
    private func setup() {
        self.setupLabels()
        self.setupTableView()
    }
    
    private func setupLabels() {
        
        foodTitle.applyDefaultSetup()
        foodTitle.text = model.title
        foodPublisher.applyDefaultSetup()
        foodPublisher.text = model.publisher
        foodRank.applyDefaultSetup()
        foodRank.text = "\(model.socialRank)"
        foodSource.applyDefaultSetup()
        foodSource.text = model.sourceURL
        downloadPlayerImage(url: model.imageURL)
    }
    
    private func setupTableView() {
        self.IngredientsTableView.delegate = self
        self.IngredientsTableView.dataSource = self
        self.IngredientsTableView.rowHeight = UITableView.automaticDimension
        self.IngredientsTableView.estimatedRowHeight = 20.0
        self.IngredientsTableView.tableFooterView = UIView()
        self.IngredientsTableView.register(cellType: IngredientsTableViewCell.self)
    }
    
    private func downloadPlayerImage(url: String) {
        guard let imgUrl = URL(string: url) else { return }
        Food2ForkWs.downloadImageFromUrl(imgUrl) { (downloadedImage) in
            self.foodImageView.image = downloadedImage
        }
    }
    
}

// MARK: - UITableView Setup
extension FoodDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = IngredientsTableView.dequeueReusableCell(for: indexPath) as IngredientsTableViewCell
        guard let ingredients = ingredients else { return cell }
        cell.prepare(with: ingredients[indexPath.row])
        return cell
    }
  
}
