//
//  FirstViewController.swift
//
//  Created by Haroen Viaene on 02/05/16.
//

import UIKit
import CoreLocation
import MapKit

class FirstViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var checkin: UIButton!
    @IBOutlet weak var distance: UILabel!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
    }
    
}

