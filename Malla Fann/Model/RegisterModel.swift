//
//  RegisterModel.swift
//  Malla Fann
//
//  Created by dorra on 20/4/2022.
//

import Foundation


struct RegisterModel: Encodable{
    let name: String
    let prenom: String
    let email: String
    let password: String
}
