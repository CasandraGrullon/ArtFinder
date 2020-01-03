//
//  ArtFinderTests.swift
//  ArtFinderTests
//
//  Created by casandra grullon on 12/28/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import XCTest
@testable import ArtFinder

class ArtFinderTests: XCTestCase {


    func testGetArtists(){
        let artID = "4d8b92684eb68a1b2c00009e"
        let link = "https://api.artsy.net/api/artists/\(artID)"

        let exp = XCTestExpectation(description: "artist found, info generated")
        
        ArtFinderAPIClient.getArtist(with: artID) { (result) in
            switch result {
            case .failure(let apperror):
                XCTFail("\(apperror)")
            case .success(let artist):
                XCTAssertEqual(link, artist.links?.selflink?.href, "\(link) should be the same as \(artist.links?.selflink?.href)")
            }
        }
        
        
    }
}
