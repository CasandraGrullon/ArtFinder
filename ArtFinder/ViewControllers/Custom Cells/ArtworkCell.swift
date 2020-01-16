//
//  ArtworkCell.swift
//  ArtFinder
//
//  Created by casandra grullon on 1/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class ArtworkCell: UICollectionViewCell {
    
    @IBOutlet weak var artworkImage: UIImageView!
    
    func configureCell(for artwork: Artwork) {
        artworkImage.getImage(with: artwork.links?.thumbnail?.href ?? "") { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.artworkImage.image = UIImage(systemName: "photo.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.artworkImage.image = image
                }
            }
        }
    }
}
