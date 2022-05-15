//
//  User.swift
//  Malla Fann
//
//  Created by dorra on 20/4/2022.
//

import Foundation

//: Encodable
struct User {
    
    internal init(_id: String? = nil, firstname: String? = nil, lastname: String? = nil, email: String? = nil, password: String? = nil, pictureId: String? = nil, isVerified: Bool? = nil) {
        self._id = _id
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.password = password
        self.pictureId = pictureId
        self.isVerified = isVerified
    }
    
    
    var _id: String?
    var firstname: String?
    var lastname: String?
    var email: String?
    var password: String?
    var pictureId: String?
    var isVerified: Bool?
    
}
