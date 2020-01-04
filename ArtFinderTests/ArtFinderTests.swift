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
        
        ArtFinderAPIClient.getArtist(with: artID) { (result) in
            switch result {
            case .failure(let apperror):
                XCTFail("\(apperror)")
            case .success(let artist):
                XCTAssertEqual(link, artist.links?.selflink?.href, "\(link) should be the same as \(artist.links?.selflink?.href)")
            }
        }
    }
    
    func testGetArtworks(){
        let artID = "4d8b92944eb68a1b2c000264"
        
        let exp = XCTestExpectation(description: "data should return more than 0 artworks")
                
        ArtFinderAPIClient.getArtworks(with: artID) { (result) in
            switch result {
            case .failure(let error):
                XCTFail("\(error)")
            case .success(let data):
                exp.fulfill()
                XCTAssertNil(false, "\(data) is not empty")
            }
        }
        wait(for: [exp], timeout: 5.0)
        
    }
}
