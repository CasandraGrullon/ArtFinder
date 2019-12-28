//
//  Artist.swift
//  ArtFinder
//
//  Created by casandra grullon on 12/28/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import Foundation

struct ArtistInfo: Codable {
    let links: Links
}
struct Link: Codable {
    let thumbnail: Thumbnail
    let mediumImage: MediumImage
    let artworks: Artworks
}
struct Thumbnail: Codable {
    let href: String
}
struct MediumImage: Codable {
    let href: String
}
struct Artworks: Codable {
    let href: String
}
