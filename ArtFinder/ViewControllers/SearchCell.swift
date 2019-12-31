//
//  SearchCell.swift
//  ArtFinder
//
//  Created by casandra grullon on 12/30/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var artSearch: Results?
    
    func configureCell(for search: Results) {
        artistNameLabel.text = search.title
        artistImageView.getImage(with: search.links?.thumbnail?.href ?? "") { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.artistImageView.image = UIImage(systemName: "person")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.artistImageView.image = image
                }
            }
        }
    }
}
