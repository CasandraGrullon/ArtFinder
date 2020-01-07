//
//  MuseumLocationViewController.swift
//  ArtFinder
//
//  Created by casandra grullon on 1/6/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import MapKit

class ArtLocation: NSObject, MKAnnotation {
    var art: Artwork?
    let coordinate: CLLocationCoordinate2D
    
    init(art: Artwork, coordinate: CLLocationCoordinate2D){
        self.art = art
        self.coordinate = coordinate
        super.init()
    }
}

class MuseumLocationViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    
    var artworks: ArtLocation?
    var coordinates: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocation()
        print(artworks?.art?.collectingInstitution)
        map.delegate = self
    }
    
    
    
    func getLocation() {
        let location = artworks?.art?.collectingInstitution
        LocationService.getCoordinates(addressString: location ?? "New York") { [weak self] (coordinate, error) in
            if let error = error{
                print("this is a\(error) type error")
            } else {
                self?.coordinates?.latitude = coordinate.latitude
                self?.coordinates?.longitude = coordinate.longitude
            }
        }
    }
    
}
extension MuseumLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? ArtLocation else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
