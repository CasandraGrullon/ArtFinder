//
//  Artist.swift
//  ArtFinder
//
//  Created by casandra grullon on 12/28/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import Foundation

struct ArtistInfo: Codable {
    let id: String?
    let name: String?
    let links: Link?
    let biography: String?
    let birthday: String?
    let deathday: String?
    let nationality: String?
}
struct Link: Codable {
    let thumbnail: Small?
    let mediumImage: MediumImage?
    let artworks: Artworks?
}
struct Small: Codable {
    let href: String?
}
struct MediumImage: Codable {
    let href: String?
}
struct Artworks: Codable {
    let href: String?
}
