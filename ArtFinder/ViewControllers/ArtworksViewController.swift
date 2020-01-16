//
//  ArtworksViewController.swift
//  ArtFinder
//
//  Created by casandra grullon on 1/3/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class ArtworksViewController: UIViewController {

    @IBOutlet weak var artworkCollection: UICollectionView!
    
    var artist: ArtistInfo?
    var artworks = [Artwork]() {
        didSet{
            DispatchQueue.main.async {
                self.artworkCollection.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        artworkCollection.delegate = self
        artworkCollection.dataSource = self
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
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let detailVC = segue.destination as? ArtworkDetailViewController, let indexPath = artworkTableview.indexPathForSelectedRow else {
//            fatalError("issue in artwork segue")
//        }
//        detailVC.artwork = artworks[indexPath.row]
//    }
}
extension ArtworksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artworks.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artworkCell", for: indexPath) as? ArtworkCell else {
            fatalError("could not downcast to artwork cell")
        }
        let artwork = artworks[indexPath.row]
        cell.configureCell(for: artwork)
        return cell
    }
}
extension ArtworksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return 
    }
    
}
