//
//  ArtFinderAPIClient.swift
//  ArtFinder
//
//  Created by casandra grullon on 12/28/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import Foundation

struct ArtFinderAPIClient {
    
    static func getSearch(for search: String, completion: @escaping (Result<[Results], AppError>) -> () ) {
        
        let seperatedWords = search.components(separatedBy: " ")
        let plusPlus = seperatedWords.joined(separator: "+")
        let searchQuery = plusPlus
        let endpointUrl = "https://api.artsy.net/api/search?q=\(searchQuery)"
        
        guard let url = URL(string: endpointUrl) else {
            completion(.failure(.badURL(endpointUrl)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJyb2xlcyI6IiIsInN1YmplY3RfYXBwbGljYXRpb24iOiI1ZTA3OWRhMjk4NmVlMjAwMGVmM2U3YmQiLCJleHAiOjE1NzgxNjI1OTQsImlhdCI6MTU3NzU1Nzc5NCwiYXVkIjoiNWUwNzlkYTI5ODZlZTIwMDBlZjNlN2JkIiwiaXNzIjoiR3Jhdml0eSIsImp0aSI6IjVlMDc5ZjIyZDE4YzlhMDAxMWZkNGU2YiJ9.cxWoR_e2u0m9Dj3M8e8kLVz8TsUxcZEqP789cbTbP8U", forHTTPHeaderField: "X-Xapp-Token")
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let artResults = try JSONDecoder().decode(ArtistResults.self, from: data)
                    let searchResults = artResults.embedded.results.filter{$0.type == "artist"}
                    completion(.success(searchResults))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }

    
    static func getArtist(with artID: String, completion: @escaping (Result<ArtistInfo, AppError>) -> ()) {

        let endpointURL = "https://api.artsy.net/api/artists/\(artID)"

        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJyb2xlcyI6IiIsInN1YmplY3RfYXBwbGljYXRpb24iOiI1ZTA3OWRhMjk4NmVlMjAwMGVmM2U3YmQiLCJleHAiOjE1NzgxNjI1OTQsImlhdCI6MTU3NzU1Nzc5NCwiYXVkIjoiNWUwNzlkYTI5ODZlZTIwMDBlZjNlN2JkIiwiaXNzIjoiR3Jhdml0eSIsImp0aSI6IjVlMDc5ZjIyZDE4YzlhMDAxMWZkNGU2YiJ9.cxWoR_e2u0m9Dj3M8e8kLVz8TsUxcZEqP789cbTbP8U", forHTTPHeaderField: "X-Xapp-Token")
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let artistResults = try JSONDecoder().decode(ArtistInfo.self, from: data)
                    completion(.success(artistResults))
                }catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func getArtworks(with artID: String, completion: @escaping (Result<[Artworks], AppError>) -> ()) {
        
        let endpointURL = "https://api.artsy.net/api/artworks?artist_id=\(artID)"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJyb2xlcyI6IiIsInN1YmplY3RfYXBwbGljYXRpb24iOiI1ZTA3OWRhMjk4NmVlMjAwMGVmM2U3YmQiLCJleHAiOjE1NzgxNjI1OTQsImlhdCI6MTU3NzU1Nzc5NCwiYXVkIjoiNWUwNzlkYTI5ODZlZTIwMDBlZjNlN2JkIiwiaXNzIjoiR3Jhdml0eSIsImp0aSI6IjVlMDc5ZjIyZDE4YzlhMDAxMWZkNGU2YiJ9.cxWoR_e2u0m9Dj3M8e8kLVz8TsUxcZEqP789cbTbP8U", forHTTPHeaderField: "X-Xapp-Token")
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let artworkResults = try JSONDecoder().decode(Embed.self, from: data)
                    let artworks = artworkResults.artworks
                    completion(.success(artworks))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
    
}
