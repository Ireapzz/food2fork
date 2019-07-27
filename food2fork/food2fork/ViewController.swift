//
//  ViewController.swift
//  food2fork
//
//  Created by Dany Tixador on 27/07/2019.
//  Copyright © 2019 Dany Tixador. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var foodTableView: UITableView!
    
    // MARK: - Private properties
    private var foodList: FoodFork? {
        didSet {
            self.foodTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        webService()
    }

}

// MARK: - WebService
extension ViewController {
    private func webService() {
        let activityIndicator = UIActivityIndicatorView(style: .gray)// Create the activity indicator
        activityIndicator.center = self.foodTableView.center
        self.foodTableView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        let callApi = Food2ForkWs()
        callApi.searchFood(with: "chicken") { food in
            self.foodList = food
            activityIndicator.stopAnimating() // On response stop animating
            activityIndicator.removeFromSuperview() // remove the view
        }
    }
}

// MARK: - Configuration Setup
extension ViewController {
    private func setup() {
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.foodTableView.delegate = self
        self.foodTableView.dataSource = self
        self.foodTableView.rowHeight = UITableView.automaticDimension
        self.foodTableView.estimatedRowHeight = 40.0
        self.foodTableView.tableFooterView = UIView()
        self.foodTableView.register(cellType: FoodsTableViewCell.self)
    }
    
}


// MARK: - UITableView Setup
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foodList?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = foodTableView.dequeueReusableCell(for: indexPath) as FoodsTableViewCell
        if let food = foodList {
            cell.prepare(with: food.recipes[indexPath.row])
        }
        return cell
    }
    
}
