//
//  Publication.swift
//  Malla Fann
//
//  Created by dorra on 5/5/2022.
//

import Foundation

struct Publicationn {
    internal init(_id: String?=nil, description: String?=nil, date: Date?=nil, pictureId: String?=nil, utilisateur: User?=nil) {
        self._id = _id

        self.description = description
        self.date = date
        self.pictureId = pictureId
        self.utilisateur = utilisateur


    }
    
    
    let _id : String?

    let description : String?
    let date : Date?
    let pictureId : String?
    
    // relations

    let utilisateur : User?

    
}
