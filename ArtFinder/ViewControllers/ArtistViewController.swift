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
    var artwork: ArtworkArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = artistInfo?.name
        loadArtistInfo()
    }
    
    func loadArtistInfo() {
        let link = searchResults?.links?.selflink?.href?.components(separatedBy: "/")
        let artID = link?.last ?? ""
        ArtFinderAPIClient.getArtist(with: artID) { [weak self] (result) in
            switch result {
            case .failure(let artistError):
                print(artistError)
            case .success(let artist):
                self?.artistInfo = artist
                DispatchQueue.main.async {
                    self?.artistBio.text = artist.biography
                    self?.yearsAliveLabel.text = "\(artist.birthday ?? "1993") - \(artist.deathday ?? "1993")"
                    self?.nationalityLabel.text = artist.nationality
                    self?.artistImage.getImage(with: artist.links?.image?.href ?? "", completion: { (result) in
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
        guard let artworksVC = segue.destination as? ArtworksViewController else {
            fatalError("segue issue on artworks button")
        }
        artworksVC.artworks = [artwork!]
    }
    
}



