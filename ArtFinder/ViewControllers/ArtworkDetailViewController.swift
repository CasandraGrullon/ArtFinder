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
        updateUI()
        navigationItem.title = artwork?.title
    }

    func updateUI() {
        categoryLabel.text = artwork?.category
        mediumLabel.text = artwork?.medium
        dateLabel.text = artwork?.date
        dimensionsLabel.text = artwork?.dimensions?.dimensions?.text
        locationLabel.text = "Currently displayed at \(artwork?.collectingInstitution ?? "")"
        artImage.getImage(with: artwork?.links?.thumbnail?.href ?? "") { [weak self] (result) in
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
