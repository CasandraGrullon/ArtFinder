//
//  Artworks.swift
//  ArtFinder
//
//  Created by casandra grullon on 12/28/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import Foundation

struct Art: Codable {
    let embedded: Embed

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}

struct Embed: Codable {
    let artworks: [Artwork]?
}

struct Artwork: Codable {
    let title: String?
    let category: String?
    let medium: String?
    let date: String?
    let dimensions: Dimensions?
    let collectingInstitution: String?
    let links: ArtworkLinks?

    enum CodingKeys: String, CodingKey {
        case title
        case category
        case medium
        case date
        case dimensions
        case collectingInstitution = "collecting_institution"
        case links = "_links"
    }
}
struct Dimensions: Codable {
    let dimensions: Inches?

    enum CodingKeys: String, CodingKey {
        case dimensions = "in"
    }
}
struct Inches: Codable {
    let text: String?
}
struct ArtworkLinks: Codable {
    let thumbnail: Next?
    let image: Image?
}
struct Next: Codable {
    let href: String?
}
struct Image: Codable {
    let href: String?
}

