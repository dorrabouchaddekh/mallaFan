//
//  Location.swift
//  Malla Fann
//
//  Created by dorra on 18/5/2022.
//


import Foundation

struct Location {
    
    internal init(id: String? = nil, name: String? = nil, categorie: String? = nil, capacity : Int? = nil, owner : Publicationn? = nil, latitude : Double? = nil, longitude : Double? = nil) {
        self.id = id
        self.name = name
        self.categorie = categorie
        self.capacity = capacity
        self.owner = owner
        self.latitude = latitude
        self.longitude = longitude
    }
    var id : String?
    var name : String?
    var categorie : String?
    var capacity : Int?
    let owner : Publicationn?
    var latitude : Double?
    var longitude : Double?
}
