//
//  Link.swift
//  Malla Fann
//
//  Created by dorra on 14/5/2022.
//

import Foundation


struct Link {
    internal init(_id: String?=nil, title: String?=nil, url: String?=nil, utilisateur: User?=nil) {
        self._id = _id

        self.title = title
        self.url = url
        self.utilisateur = utilisateur


    }
    
    
    let _id : String?

    let title : String?
    let url : String?
    
    // relations

    let utilisateur : User?

    
}
