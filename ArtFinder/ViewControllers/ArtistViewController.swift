//
//  ArtistViewController.swift
//  ArtFinder
//
//  Created by casandra grullon on 12/31/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController {
    
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var yearsAliveLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var artistBio: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var searchResults: Results?
    var artistInfo: ArtistInfo?
    var artworks = [ArtworkArray]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadArtistInfo()
        loadArtworks()
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = artistInfo?.name
    }
    
    func loadArtistInfo() {
        ArtFinderAPIClient.getArtist(with: artistInfo?.id ?? "") { [weak self] (result) in
            switch result{
            case .failure(let artistError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Artist Error", message: "\(artistError)")
                }
            case .success(let artist):
                self?.artistInfo = artist
                DispatchQueue.main.async {
                    self?.yearsAliveLabel.text = "\(artist.birthday ?? "") - \(artist.deathday ?? "")"
                    self?.nationalityLabel.text = artist.nationality
                    self?.artistBio.text = artist.biography
                    self?.artistImage.getImage(with: artist.links?.mediumImage?.href ?? "", completion: { (result) in
                        switch result {
                        case .failure:
                            self?.artistImage.image = UIImage(systemName: "person")
                        case .success(let image):
                            self?.artistImage.image = image
                        }
                    })
                }
                
            }
        }
        
        
    }
    
    func loadArtworks() {
        ArtFinderAPIClient.getArtworks(with: artistInfo?.id ?? "4d8b92b34eb68a1b2c0003f4") { [weak self] (result) in
            switch result {
            case .failure(let artworkError):
                //print("artwork error \(artworkError)")
                DispatchQueue.main.async {
                    self?.showAlert(title: "Artwork Error", message: "\(artworkError)")
                }
            case .success(let artwork):
                self?.artworks = artwork
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let artworkDetails = segue.destination as? ArtworkDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("issue in artist to artwork segue")
        }
        artworkDetails.artwork = artworks[indexPath.row]
    }
}

extension ArtistViewController: UITableViewDataSource {
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

