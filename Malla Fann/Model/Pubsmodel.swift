//
//  PubsModel.swift
//  Malla Fann
//
//  Created by dorra on 26/4/2022.
//

import Foundation

//: Encodable
struct Publication {
    
    internal init(_id: String? = nil, title: String? = nil, description: String? = nil, categoriedata: String? = nil, photo: String? = nil, nbrPhotos: String? = nil, video: String? = nil, audio: String? = nil, enchere: String? = nil) {
        self._id = _id
        self.title = title
        self.description = description
        self.categoriedata = categoriedata
        self.photo = photo
        self.nbrPhotos = nbrPhotos
        self.video = video
        self.audio = audio
        self.enchere = enchere
    }
    
    
    var _id: String?
    var title: String?
    var description: String?
    var categoriedata: String?
    var photo: String?
    var nbrPhotos: String?
    var video: String?
    var audio: String?
    var enchere: String?
    
}

