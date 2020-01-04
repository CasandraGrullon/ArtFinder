//
//  Artworks.swift
//  ArtFinder
//
//  Created by casandra grullon on 12/28/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import Foundation

////struct Artwork: Codable {
////    let embed: Embed
////
////    enum CodingKeys: String, CodingKey {
////        case embed = "_embedded"
////    }
////}
////struct Embed: Codable {
////    let artworks: Artworks?
////}
//struct Artworks: Codable {
//    let id: String?
//    let title: String?
//    let category: String?
//    let medium: String?
//    let date: String?
//    let dimensions: Dimensions?
//    let imageLinks: ImageLinks?
//    let location: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case title
//        case category
//        case medium
//        case date
//        case dimensions
//        case imageLinks = "_links"
//        case location = "collection_institution"
//    }
//}
//struct Dimensions: Codable {
//    let inches: Inches?
//
//    enum CodingKeys: String, CodingKey {
//        case inches = "in"
//    }
//}
//struct Inches: Codable {
//    let text: String?
//}
//struct ImageLinks: Codable {
//    let thumbnail: Thumb?
//    let permalink: LargeImage?
//}
//struct Thumb: Codable {
//    let href: String?
//}
//struct LargeImage: Codable {
//    let href: String?
//}
//
struct Empty: Codable {
    let embedded: Embed

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}

struct Embed: Codable {
    let artworks: [Artwork]
}

struct Artwork: Codable {
    let title: String
    let category: String
    let medium: String
    let date: String
    let dimensions: Dimensions
    let collectingInstitution: String
    let links: ArtworkLinks

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
    let dimensions: Inches

    enum CodingKeys: String, CodingKey {
        case dimensions = "in"
    }
}
struct Inches: Codable {
    let text: String
}
struct ArtworkLinks: Codable {
    let thumbnail: Next
    let image: Image
}
struct Next: Codable {
    let href: String
}
struct Image: Codable {
    let href: String
}

