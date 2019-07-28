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
    @IBOutlet private weak var foodTableView: UITableView!
    @IBOutlet private weak var foodSearchBar: UISearchBar!
    
    // MARK: - Private properties
    private var foodList: FoodFork? {
        didSet {
            self.foodTableView.reloadData()
        }
    }
    
    var searchFood = String()

    let callApi = Food2ForkWs()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        webService()
    }

}

// MARK: - WebService
extension ViewController {
    private func webService() {
        callApi.searchFood(with: "") { food in
            self.foodList = food
        }
    }
}

// MARK: - Configuration Setup
extension ViewController {
    private func setup() {
        self.setupTableView()
        self.setupSearchBar()
    }
    
    private func setupTableView() {
        self.foodTableView.delegate = self
        self.foodTableView.dataSource = self
        self.foodTableView.rowHeight = UITableView.automaticDimension
        self.foodTableView.estimatedRowHeight = 40.0
        self.foodTableView.tableFooterView = UIView()
        self.foodTableView.register(cellType: FoodsTableViewCell.self)
    }
    
    private func setupSearchBar() {
        self.foodSearchBar.delegate = self
        self.foodSearchBar.translatesAutoresizingMaskIntoConstraints = false
        self.foodSearchBar.searchBarStyle = .minimal
        self.foodSearchBar.isUserInteractionEnabled = true

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let food = foodList {
            let sender = food.recipes[indexPath.row]
            self.performSegue(withIdentifier: "detailsFood", sender: sender)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let food = sender as! Recipe
        
        switch segue.destination {
        case let vc as FoodDetailsViewController:
            vc.model = food
            
        default:
            break
        }
        
        
    }
    
}

// MARK : - UISearchBar Setup
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: nil)
        searchFood = searchText
        self.perform(#selector(reload), with: nil, afterDelay: 1)
    }
    
    @objc func reload() {
        print(searchFood)
        callApi.searchFood(with: searchFood) { food in
            self.foodList = food
        }
    }
}
