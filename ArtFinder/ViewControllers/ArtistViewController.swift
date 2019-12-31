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
    
    var artistInfo: ArtistInfo?
    var artworks = [Artwork]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadArtistInfo()
        navigationItem.title = artistInfo?.name

    }

    func loadArtistInfo() {
        ArtFinderAPIClient.getArtist(with: artistInfo?.id ?? "4d8b92b34eb68a1b2c0003f4") { [weak self] (result) in
            switch result{
            case .failure(let appError) :
                DispatchQueue.main.async {
                    self?.showAlert(title: "App Error", message: "\(appError)")
                }
            case .success(let artist):
                self?.artistInfo = artist
            }
        }
    }
    
    func loadArtworks() {
        
    }
    

}
