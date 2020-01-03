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
    var name: String?
    var links: Link?
    let biography: String?
    let birthday: String?
    let deathday: String?
    let nationality: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case links = "_links"
        case biography
        case birthday
        case deathday
        case nationality
    }
}
struct Link: Codable {
    let thumbnail: Small?
    var selflink: Permalink?
    let artworks: Artworks?

    enum CodingKeys: String, CodingKey {
        case thumbnail
        case selflink = "self"
        case artworks
    }
}
struct Small: Codable {
    let href: String?
}
struct Artworks: Codable {
    let href: String?
}
struct Permalink: Codable {
    var href: String?
}
