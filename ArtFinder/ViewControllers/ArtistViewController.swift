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
    
    var searchResults: Results?
    var artistInfo: ArtistInfo?
    var artworks: ArtworkArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if searchResults?.links?.artistLink?.href == artistInfo?.links?.linkToApi?.href {
            loadArtistInfo()
        }
        navigationItem.title = artistInfo?.name
    }
    
    func loadArtistInfo() {
        ArtFinderAPIClient.getArtist(with: artistInfo?.id ?? "4d8b92944eb68a1b2c000264") { [weak self] (result) in
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
                }
            }
        }
        artistImage.getImage(with: artistInfo?.links?.mediumImage?.href ?? "https://d32dm0rphc51dk.cloudfront.net/wMhDVMZP68ERKRVE_c1k-g/{image_version}.jpg") { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.artistImage.image = UIImage(systemName: "person")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.artistImage.image = image
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let artworkDetails = segue.destination as? ArtworkDetailViewController else {
            fatalError("issue in artist to artwork segue")
        }
        artworkDetails.artwork = artworks
    }
}

//extension ArtistViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return artworks.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath) as? ArtistCell else {
//            fatalError("issue in cell")
//        }
//        let art = artworks[indexPath.row]
//        cell.configureCell(for: art)
//        return cell
//    }
//}
//extension ArtistViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 180
//    }
//}

