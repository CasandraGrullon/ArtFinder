//
//  ArtworkDetailViewController.swift
//  ArtFinder
//
//  Created by casandra grullon on 12/31/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import UIKit

class ArtworkDetailViewController: UIViewController {

    @IBOutlet weak var artImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dimensionsLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var artwork: Artworks?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        navigationItem.title = artwork?.title
    }

    func updateUI() {
        guard let art = artwork else {
            return
        }
        categoryLabel.text = art.category
        mediumLabel.text = art.medium
        dateLabel.text = art.date
        dimensionsLabel.text = art.dimensions?.inches?.text
        locationLabel.text = "Currently displayed at \(art.location ?? "Not Available")"
        artImage.getImage(with: art.imageLinks?.permalink?.href ?? "") { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.artImage.image = UIImage(systemName: "paintbrush")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.artImage.image = image
                }
            }
        }
        
    }

}
