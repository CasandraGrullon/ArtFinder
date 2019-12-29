//
//  ImageViewExt.swift
//  ArtFinder
//
//  Created by casandra grullon on 12/28/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import UIKit

extension UIImageView {
  func getImage(with urlString: String,
                completion: @escaping (Result<UIImage, AppError>) -> ()) {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .orange
    activityIndicator.startAnimating()
    activityIndicator.center = center
    addSubview(activityIndicator)
    
    guard let url = URL(string: urlString) else {
      completion(.failure(.badURL(urlString)))
      return
    }
    
    let request = URLRequest(url: url)
    
    NetworkHelper.shared.performDataTask(with: request) { [weak activityIndicator] (result) in
      DispatchQueue.main.async {
        activityIndicator?.stopAnimating()
      }
      switch result {
      case .failure(let appError):
        completion(.failure(.networkClientError(appError)))
      case .success(let data):
        if let image = UIImage(data: data) {
          completion(.success(image))
        }
      }
    }
  }
}
