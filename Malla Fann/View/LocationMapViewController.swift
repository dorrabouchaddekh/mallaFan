//
//  LocationMapViewController.swift
//  Malla Fann
//
//  Created by dorra on 18/5/2022.
//

import UIKit
import MapKit
class LocationMapViewController: UIViewController , MKMapViewDelegate{
  
        //widgets
        @IBOutlet weak var mapView: MKMapView!
        
        //var
        
        var event = Event()
        var eventViewModel = EventViewModel()
        
        
        override func viewDidLoad() {
            super.viewDidLoad()

            mapView.delegate = self
        }
        

        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            let newLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
            
            
        }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "locationNext" {
            let destination = segue.destination as! EventsViewController
            destination.event = event
            let backItem = UIBarButtonItem()
                backItem.title = "Back to Map"
                navigationItem.backBarButtonItem = backItem
        }
    }
    
    @IBAction func pickLoc(_ sender: UIButton) {
        event.latitude = mapView.centerCoordinate.latitude
        event.longitude = mapView.centerCoordinate.longitude
        performSegue(withIdentifier: "locationNext", sender: event)
        
    }
        
        
    }


