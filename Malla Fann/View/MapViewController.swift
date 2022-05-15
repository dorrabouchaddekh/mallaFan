//
//  MapViewController.swift
//  Malla Fann
//
//  Created by dorra on 12/4/2022.
//

import UIKit
import CoreLocation
import MapKit


class MapViewController: UIViewController , CLLocationManagerDelegate {
    
    
    
    @IBOutlet weak var myMap: MKMapView!
    
    
    let manager = CLLocationManager()
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let location = locations[0]
        
        let span: MKCoordinateSpan = MKCoordinateSpan ( latitudeDelta: 0.01 , longitudeDelta: 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        
        myMap.setRegion(region, animated: true)
        self.myMap.showsUserLocation = true
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    


}
