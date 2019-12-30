//
//  ViewController.swift
//  ArtFinder
//
//  Created by casandra grullon on 12/28/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var artistResults = [Results]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var searchQuery = "Vincent van Gogh"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(for: searchQuery)
        tableView.dataSource = self
        searchBar.delegate = self
    }

    func loadData(for search: String) {
        ArtFinderAPIClient.getSearch(for: search) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "App Error", message: "\(appError)")
                }
            case .success(let search):
                self?.artistResults = search
            }
        }
    }

}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistResults.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchCell else {
            fatalError("issue with searchCell")
        }
        let search = artistResults[indexPath.row]
        
        cell.configureCell(for: search)
        
        return cell
    }
}
extension SearchViewController: UISearchBarDelegate {
    searc
}
