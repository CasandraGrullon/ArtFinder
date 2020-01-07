//
//  MuseumLocationViewController.swift
//  ArtFinder
//
//  Created by casandra grullon on 1/6/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
//
//class ArtLocation: NSObject, MKAnnotation {
//    var location: String
//    let coordinate: CLLocationCoordinate2D
//
//    init(location: String, coordinate: CLLocationCoordinate2D){
//        self.location = location
//        self.coordinate = coordinate
//        super.init()
//    }
//    var subtitle: String? {
//       return location
//     }
//}

class MuseumLocationViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    
    var artworks: Artwork?
    var coordinateINeed: CLLocationCoordinate2D?
    private var annotations = [MKAnnotation]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocation()
        //makeAnnotations()
        //print(artworks?.art?.collectingInstitution)
    }
    
    func getLocation() {
        let location = artworks?.collectingInstitution
        LocationService.getCoordinates(addressString: location ?? "New York") { [weak self] (coordinate, error) in
            if let error = error{
                print("this is a\(error) type error")
            } else {
                self?.coordinateINeed = coordinate
                
                self?.makeAnnotations()
            }
        }
    }
}

extension MuseumLocationViewController{
    private func makeAnnotations() {
        map.removeAnnotations(annotations)
        annotations.removeAll()
        let annotation = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2D.init(latitude: coordinateINeed!.latitude, longitude: coordinateINeed!.longitude)
        annotation.coordinate = coordinate
        annotation.title = artworks?.collectingInstitution
        self.annotations.append(annotation)
        map.showAnnotations(annotations, animated: true)
    }
}


