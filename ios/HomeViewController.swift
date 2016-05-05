//
//  FirstViewController.swift
//
//  Created by Haroen Viaene on 02/05/16.
//

import UIKit
import CoreLocation
import MapKit

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
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
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(UIApplicationDelegate.applicationDidBecomeActive(_:)),
            name: UIApplicationDidBecomeActiveNotification,
            object: nil)
    }
    
    func currentCity(location: CLLocation) {
        map.removeAnnotations(map.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        annotation.title = "Current location"
        map.addAnnotation(annotation)
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
    
    func applicationDidBecomeActive(notification: NSNotification) {
        getQuickLocationUpdate()
    }
    
    func getQuickLocationUpdate() {
        // Request a location update
        self.locationManager.startUpdatingLocation()
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
//        map.showsUserLocation = true
        
        currentCity(location);
        self.locationManager.stopUpdatingLocation()
    }
}

