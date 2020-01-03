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
        loadInfo(for: searchResults!, and: artistInfo?.id ?? "4d8b92944eb68a1b2c000264")
        //loadArtistInfo(for: searchResults!, artID: artistInfo?.id ?? "5977a8a4a09a6770c614ad1a")
        navigationItem.title = artistInfo?.name
    }
    
//    func loadArtistInfo(for searchResult: Results, artID: String) {
//        if searchResult.links?.selflink?.href == "https://api.artsy.net/api/artists/\(artID)" {
//            ArtFinderAPIClient.getArtist(with: artID) { [weak self] (result) in
//                switch result{
//                case .failure(let artistError):
//                    DispatchQueue.main.async {
//                        self?.showAlert(title: "Artist Error", message: "\(artistError)")
//                    }
//                case .success(let artist):
//                    self?.artistInfo = artist
//                    DispatchQueue.main.async {
//                        self?.yearsAliveLabel.text = "\(artist.birthday ?? "") - \(artist.deathday ?? "")"
//                        self?.nationalityLabel.text = artist.nationality
//                        self?.artistBio.text = artist.biography
//                        self?.artistImage.getImage(with: artist.links?.image?.href ?? "", completion: { (result) in
//                            switch result {
//                            case .failure:
//                                self?.artistImage.image = UIImage(systemName: "person")
//                            case .success(let image):
//                                self?.artistImage.image = image
//                            }
//                        })
//                    }
//                }
//            }
//        }
//    }

    func loadInfo(for searchLink: Results, and artID: String) {
        ArtFinderAPIClient.getArtistFromSearch(for: searchLink, with: artID) { [weak self] (result) in
            switch result {
            case .failure(let gafsError):
                print(gafsError)
            case .success(let artInfo):
                self?.artistInfo = artInfo
                DispatchQueue.main.async {
                    self?.artistBio.text = artInfo.biography
                    self?.nationalityLabel.text = artInfo.nationality
                    self?.yearsAliveLabel.text = "\(artInfo.birthday ?? "1993") - \(artInfo.deathday ?? "2089")"
                    self?.artistImage.getImage(with: artInfo.links?.image?.href ?? "", completion: { (result) in
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let artworkDetails = segue.destination as? ArtworkDetailViewController else {
            fatalError("issue in artist to artwork segue")
        }
        artworkDetails.artwork = artworks
    }
}



