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
        
        let searchQuery = search.lowercased().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "Picasso"
        let endpointUrl = "https://api.artsy.net/api/search?q=\(searchQuery)"
        
        guard let url = URL(string: endpointUrl) else {
            completion(.failure(.badURL(endpointUrl)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let searchResults = try JSONDecoder().decode([Results].self, from: data)
                    completion(.success(searchResults))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func getArtist(with artID: String, completion: @escaping (Result<[ArtistInfo], AppError>) -> ()) {
        
        let endpointURL = "https://api.artsy.net/api/artists/\(artID)"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let artistResults = try JSONDecoder().decode([ArtistInfo].self, from: data)
                    completion(.success(artistResults))
                }catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func getArtworks(with artID: String, completion: @escaping (Result<[Artwork], AppError>) -> ()) {
        
        let endpointURL = "https://api.artsy.net/api/artworks/artist_id=\(artID)"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let artworkResults = try JSONDecoder().decode([Artwork].self, from: data)
                    completion(.success(artworkResults))
                }catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
    
}
