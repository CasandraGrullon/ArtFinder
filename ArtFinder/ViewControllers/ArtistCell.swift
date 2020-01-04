//
//  ArtistCell.swift
//  ArtFinder
//
//  Created by casandra grullon on 12/31/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import UIKit

class ArtistCell: UITableViewCell {

    @IBOutlet weak var artworkImage: UIImageView!
    @IBOutlet weak var artworkTitle: UILabel!
    @IBOutlet weak var artworkDateLabel: UILabel!
    
    var artwork: Artworks?
    
    func configureCell(for art: Artworks) {
        artworkTitle.text = art.title
        artworkDateLabel.text = art.date
        artworkImage.getImage(with: art.imageLinks?.thumbnail?.href ?? "https://d32dm0rphc51dk.cloudfront.net/5L1xjKC_und1uiKCpUPHhw/medium.jpg" ) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.artworkImage.image = UIImage(systemName: "paintbrush")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.artworkImage.image = image
                }
            }
        }
    }
    
}
