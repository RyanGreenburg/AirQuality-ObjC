//
//  CitiesListViewController.swift
//  AirQuality ObjC
//
//  Created by RYAN GREENBURG on 11/21/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class CitiesListViewController: UIViewController {
    
    // MARK: - Properties
    var state: String?
    var country: String?
    var cities: [String] = [] {
        didSet {
            updateTableView()
        }
    }
    let searchController = UISearchController()
    var filteredData: [String] = []

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchController.setupSearchControllerWith(self)
        guard let state = state,
            let country = country
            else { return }
        DVMCityAirQualityController.fetchSupportedCities(inState: state, country: country) { (cities) in
            if let cities = cities {
                self.cities = cities
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCityDetailsVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let country = country,
                let state = state,
                let destinationVC = segue.destination as? CityDetailViewController
                else { return }
            
            let selectedCity = searchController.searchIsActive ? filteredData[indexPath.row] : cities[indexPath.row]
            destinationVC.city = selectedCity
            destinationVC.state = state
            destinationVC.country = country
        }
    }
    
    // MARK: - Class Methods
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CitiesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.searchIsActive ? filteredData.count : cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        let city = searchController.searchIsActive ? filteredData[indexPath.row] : cities[indexPath.row]
        cell.textLabel?.text = city
        return cell
    }
}

extension CitiesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let searchBarText = searchBar.text else { return }
        filteredData = searchController.filer(cities, by: searchBarText)
        updateTableView()
    }
}
