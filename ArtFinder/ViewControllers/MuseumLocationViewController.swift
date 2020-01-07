//
//  MuseumLocationViewController.swift
//  ArtFinder
//
//  Created by casandra grullon on 1/6/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import MapKit

class MuseumLocationViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    
    var artworks: Artwork?
    var coordinates: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocation()
    }
    
    func getLocation() {
        let location = artworks?.collectingInstitution
        
        LocationService.getCoordinates(addressString: location ?? "New York") { [weak self] (coordinate, error) in
            if let error = error{
                print("this is a\(error) type error")
            } else {
                self?.coordinates = coordinate
            }
        }
    }
    
    
    
}
