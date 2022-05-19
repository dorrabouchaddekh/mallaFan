//
//  Event.swift
//  Malla Fann
//
//  Created by dorra on 18/5/2022.
//

import Foundation

struct Event {
    internal init(_id: String?=nil, name: String?=nil, date: Date?=nil,startDate: String?=nil, latitude : Double? = nil, longitude : Double? = nil, utilisateur: User?=nil,pictureId: String?=nil) {
        self._id = _id

        self.name = name
        
        self.date = date
        self.startDate = startDate
        self.latitude = latitude
        self.longitude = longitude
        self.utilisateur = utilisateur
        self.pictureId = pictureId

    }
    
    
    let _id : String?

    let name : String?
    let startDate : String?
    let date : Date?
    var latitude : Double?
    var longitude : Double?
    
    
    // relations

    let utilisateur : User?
    let pictureId : String?

    
}
