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
        // Create a location manager object
        self.locationManager = CLLocationManager()
        
        // Set the delegate
        self.locationManager.delegate = self
        
        getQuickLocationUpdate()
    }
    
    func currentCity(location: CLLocation) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in
            
            let placeArray = placemarks as [CLPlacemark]!
            
            var placeMark: CLPlacemark!
            placeMark = placeArray?[0]
            if let current = placeMark.addressDictionary?["City"] as? NSString {
                self.city.text = current as String
                self.distance.text = "\(0) km" as String
            }
        }
    }
    
    func getQuickLocationUpdate() {
        // Request location authorization
        self.locationManager.requestWhenInUseAuthorization()
        
        // Request a location update
        self.locationManager.requestLocation()
        // Note: requestLocation may timeout and produce an error if authorization has not yet been granted by the user
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Process the received location update
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
        
        currentCity(location);
    }
}

