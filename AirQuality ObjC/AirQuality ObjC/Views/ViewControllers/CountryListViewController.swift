//
//  CountryListViewController.swift
//  AirQuality ObjC
//
//  Created by RYAN GREENBURG on 11/21/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class CountryListViewController: UIViewController {
    // MARK: - Properties
    var countries: [String] = [] {
        didSet {
            updateTableView()
        }
    }
    let searchController = UISearchController()
    var filteredData: [String] = []

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchController.setupSearchControllerWith(self)
        navigationItem.searchController = searchController
        DVMCityAirQualityController.fetchSupportedCountries { (countries) in
            if let countries = countries {
                self.countries = countries
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStatesVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? StatesListViewController
                else { return }
            
            let selectedCountry = searchController.searchIsActive ? filteredData[indexPath.row] : countries[indexPath.row]
            
            destinationVC.country = selectedCountry
        }
    }
    
    // MARK: - Class Method
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - TableView DataSource/Delegate
extension CountryListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.searchIsActive ? filteredData.count : countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        let country = searchController.searchIsActive ? filteredData[indexPath.row] : countries[indexPath.row]
        cell.textLabel?.text = country
        return cell
    }
}

// MARK: - UISearchResultsUpdating
extension CountryListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let searchBarText = searchBar.text else { return }
        filteredData = searchController.filer(countries, by: searchBarText)
        updateTableView()
    }
}
