//
//  ArtworksViewController.swift
//  ArtFinder
//
//  Created by casandra grullon on 1/3/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class ArtworksViewController: UIViewController {
    
    @IBOutlet weak var artworkTableview: UITableView!
    
    var artist: ArtistInfo?
    
    var artworks = [Artwork]() {
        didSet{
            DispatchQueue.main.async {
                self.artworkTableview.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artworkTableview.dataSource = self
        artworkTableview.delegate = self
        loadArtworks(for: artist!)
        navigationItem.title = artist?.name
    }
    
    func loadArtworks(for artist: ArtistInfo) {
        ArtFinderAPIClient.getArtworks(with: artist.id ?? "4d8b92684eb68a1b2c00009e") { [weak self] (result) in
            switch result {
            case .failure(let arterror):
                print(arterror)
            case .success(let artworkslist):
                self?.artworks = artworkslist.artworks!
            }
        }
    }
}

extension ArtworksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artworks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = artworkTableview.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath) as? ArtistCell else {
            fatalError("issue with artist cell")
        }
        let art = artworks[indexPath.row]
        cell.configureCell(for: art)
        return cell
    }
}

extension ArtworksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
