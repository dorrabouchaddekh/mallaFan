//
//  LocationCellViewController.swift
//  Malla Fann
//
//  Created by dorra on 18/5/2022.
//

import UIKit

import MapKit
import CoreLocation
import Foundation

class LocationCellViewController: UIViewController {

    var event = Event()
    
    @IBOutlet weak var mapLoc: MKMapView!
    
    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBOutlet weak var startDate: UILabel!
    
    
    @IBOutlet weak var endDate: UIDatePicker!
    
    @IBOutlet weak var eventPhoto: UIImageView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        self.eventNameLabel.text = event.name
        self.endDate.date = (event.date)!
        self.startDate.text = event.startDate
        self.eventPhoto.loadFrom(URLAddress: Constant.host+(event.pictureId)!)
        
        
        
        

        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: event.latitude!, longitude: event.longitude!)
        let region = MKCoordinateRegion(center: annotation1.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

        self.mapLoc.addAnnotation(annotation1)
        
        
        mapLoc.setRegion(region, animated: true)
        
        
        // Do any additional setup after loading the view.
    }
    


}
