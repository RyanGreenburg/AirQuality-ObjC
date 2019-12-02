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
    private enum Section {
        case main
    }
    var countries: [String] = [] {
        didSet {
            updateDataSource(with: self.countries, animated: true)
        }
    }
    private var dataSource: UICollectionViewDiffableDataSource<Section, String>?
    
    let searchController = UISearchController()
    var filteredData: [String] = []

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.setupSearchControllerWith(self)
        navigationItem.searchController = searchController
        configureCollectionView()
        DVMCityAirQualityController.fetchSupportedCountries { (countries) in
            if let countries = countries {
                self.countries = countries
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStatesVC" {
            guard let dataSource = dataSource,
                let indexPath = collectionView.indexPathsForSelectedItems,
                let selecedCountry = dataSource.itemIdentifier(for: indexPath.first!),
                let destinationVC = segue.destination as? StatesListViewController
                else { return }
            
            destinationVC.country = selecedCountry
        }
    }
    
    // MARK: - Class Method
    func configureCollectionView() {
        collectionView.delegate = self
        let sectionLayout = createSectionLayout()
        let flowLayout = createFlowLayout(with: sectionLayout)
        collectionView.setCollectionViewLayout(flowLayout, animated: false)
        collectionView.layoutIfNeeded()
        setUpDataSource()
    }
    
    func setUpDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, country) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? BasicCollectionViewCell
            
            cell?.nameLabel.text = country
            cell?.backgroundColor = .systemTeal
            return cell ?? UICollectionViewCell()
        })
    }
    
    func updateDataSource(with items: [String], animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource?.apply(snapshot)
    }
    
    func createSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.interGroupSpacing = self.view.frame.height / 50
        
        return layoutSection
    }
    
    func createFlowLayout(with sectionLayout: NSCollectionLayoutSection) -> UICollectionViewLayout {
        let section = sectionLayout
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: configuration)
        return layout
    }
}

extension CountryListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toStatesVC", sender: nil)
    }
}

// MARK: - UISearchResultsUpdating
extension CountryListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let searchBarText = searchBar.text, !searchBarText.isEmpty else { return }
        filteredData = searchController.filer(countries, by: searchBarText)
        updateDataSource(with: filteredData, animated: true)
    }
}
