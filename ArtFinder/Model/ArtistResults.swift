//
//  Artist.swift
//  ArtFinder
//
//  Created by casandra grullon on 12/28/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import Foundation

struct ArtistResults: Codable {
    let embedded: Embedded
    
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}
struct Embedded: Codable {
    let results: [Results]
}
struct Results: Codable {
    let type: String?
    let title: String?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case type
        case title
        case links = "_links"
    }
}
struct Links: Codable {
    let artistLink: ArtistLink?
    let thumbnail: Thumbnail?
    
    enum CodingKeys: String, CodingKey {
        case artistLink = "self"
        case thumbnail
    }
}
struct ArtistLink: Codable {
    let href: String?
}
struct Thumbnail: Codable {
    let href: String?
}
