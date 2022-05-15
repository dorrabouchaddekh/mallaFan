//
//  RegisterViewModel.swift
//  Malla Fann
//
//  Created by dorra on 23/4/2022.
//

import Foundation
import SwiftyJSON
import Alamofire


public class RegisterViewModel: ObservableObject{


    func register(nom: String,prenom: String,email: String, password: String, idPhoto: String, completed: @escaping (Bool, Any?) -> Void) {
        AF.request(Constant.host + "api/authentification/register",
                   method: .post,
                   parameters: ["nom": nom,"prenom": prenom,"email": email, "password": password,"idPhoto": idPhoto])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                 
                    let user = self.makeItem(jsonItem: jsonData["existingUser"])
                    UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "tokenConnexion")
                    UserDefaults.standard.setValue(user._id, forKey: "_id")
                    UserDefaults.standard.setValue(user.firstname, forKey: "nom")
                    UserDefaults.standard.setValue(user.lastname, forKey: "prenom")
                    UserDefaults.standard.setValue(user.email, forKey: "email")
                    UserDefaults.standard.setValue(user.password, forKey: "password")
                    UserDefaults.standard.setValue(user.pictureId, forKey: "idPhoto")

                 
                   // print(user)
                    
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }


func makeItem(jsonItem: JSON) -> User {
    return User(
        _id: jsonItem["_id"].stringValue,
        firstname: jsonItem["firstname"].stringValue,
        lastname:  jsonItem["lastname"].stringValue,
        email: jsonItem["email"].stringValue,
        password: jsonItem["password"].stringValue,
        pictureId: jsonItem["pictureId"].stringValue

    )
}
}

