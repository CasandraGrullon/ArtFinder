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
    
    var searchQuery = "" {
        didSet {
            loadData(for: searchQuery)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(for: "Andy Warhol")
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    func loadData(for search: String) {
        ArtFinderAPIClient.getSearch(for: search) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
                print(appError)
            case .success(let artist):
                self?.artistResults = artist
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
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQuery = searchText
    }
    
}
