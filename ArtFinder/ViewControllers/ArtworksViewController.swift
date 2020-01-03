//
//  ArtworksViewController.swift
//  ArtFinder
//
//  Created by casandra grullon on 1/3/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class ArtworksViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var artworks = [ArtworkArray]() {
        didSet {
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


}
extension ArtworksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artworks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath) as? ArtistCell else {
            fatalError("issue in cell")
        }
        let art = artworks[indexPath.row]
        cell.configureCell(for: art)
        return cell
    }
}
extension ArtistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
