//
//  StatesListViewController.swift
//  AirQuality ObjC
//
//  Created by RYAN GREENBURG on 11/21/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class StatesListViewController: UIViewController {
    // MARK: - Properties
    var country: String?
    var states: [String] = [] {
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
        tableView.dataSource = self
        tableView.delegate = self
        searchController.setupSearchControllerWith(self)
        navigationItem.searchController = searchController
        guard let country = country else { return }
        DVMCityAirQualityController.fetchSupportedStates(inCountry: country) { (states) in
            if let states = states {
                self.states = states
            }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCitiesVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let country = country,
                let destinationVC = segue.destination as? CitiesListViewController
                else { return}
            let selectedState = searchController.searchIsActive ? filteredData[indexPath.row] : states[indexPath.row]
            destinationVC.country = country
            destinationVC.state = selectedState
        }
    }
    
    // MARK: - Class Methods
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension StatesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.searchIsActive ? filteredData.count : states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        let state = searchController.searchIsActive ? filteredData[indexPath.row] : states[indexPath.row]
        cell.textLabel?.text = state
        return cell
    }
}

extension StatesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let searchBarText = searchBar.text else { return }
        filteredData = searchController.filer(states, by: searchBarText)
        updateTableView()
    }
}
