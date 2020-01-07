//
//  LocationService.swift
//  ArtFinder
//
//  Created by casandra grullon on 1/6/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService {
    static func getCoordinates(addressString : String,
                                      completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
}
