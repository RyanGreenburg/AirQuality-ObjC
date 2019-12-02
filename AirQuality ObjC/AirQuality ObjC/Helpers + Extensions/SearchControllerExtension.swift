//
//  SearchControllerExtension.swift
//  AirQuality ObjC
//
//  Created by RYAN GREENBURG on 11/22/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

extension UISearchController {
    var searchBarIsEmpty: Bool {
        return self.searchBar.text?.isEmpty ?? true
    }
    var searchIsActive: Bool {
        return self.isActive && !searchBarIsEmpty
    }
    
    func filer<T: StringProtocol>(_ data: [T], by searchText: String) -> [T] {
        return data.filter({ $0.lowercased().contains(searchText.lowercased()) })
    }
    func setupSearchControllerWith<T>(_ parent: T)  where T: UISearchResultsUpdating {
        self.searchResultsUpdater = parent
        self.obscuresBackgroundDuringPresentation = false
        self.searchBar.placeholder = "Search countries"
        definesPresentationContext = true
    }
}
