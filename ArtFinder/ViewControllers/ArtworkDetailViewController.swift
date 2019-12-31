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
    
    var artwork: Artwork?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
    }

}
