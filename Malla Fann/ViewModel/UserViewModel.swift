//
//  UserViewModel.swift
//  Malla Fann
//
//  Created by dorra on 20/4/2022.
//


import SwiftyJSON
import Alamofire
import UIKit.UIImage



public class UserViewModel: ObservableObject{
    
    static let sharedInstance = UserViewModel()
    
    func inscription(user: User, completed: @escaping (Bool,User?) -> Void) {
        AF.request(Constant.host + "api/user/register",
                   method: .post,
                   parameters: [
                    "firstname": user.firstname!,
                    "lastname": user.lastname!,
                    "email": user.email!,
                    "password": user.password!,
                    "pictureId": user.pictureId!,
                   ] ,encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    let jsonData = JSON(response.data!)
                                        let utilisateur = self.makeItem(jsonItem: jsonData["uses"])
                    print(user.firstname)
                    print(user.lastname)
                    print(user.email)
                    print(user.password)
                    print(user.pictureId)
                
                    completed(true,utilisateur)
                case let .failure(error):
                    print(error)
                    completed(false,nil)
                }
            }
    }
    
    func connexion(email: String, password: String, completed: @escaping (Bool, Any?) -> Void) {
        AF.request(Constant.host + "api/user/login",
                   method: .post,
                   parameters: ["email": email, "password": password])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    print(jsonData)

                    let user = self.makeItem(jsonItem: jsonData["use"])
                    
                    
                    //UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "token")
                    print("============================aaaaa=======================")
                    print(user._id)
                    UserDefaults.standard.setValue(user._id, forKey: "_id")
                    
print("============================aaaaa=======================")
                    print(user)
                    
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    
    func recupererUtilisateurParToken(_id: String, completed: @escaping (Bool, User?) -> Void ) {
        print(_id)
        print("Looking for user --------------------")
        AF.request(Constant.host + "api/user/show",
                   method: .post,
                   parameters: ["_id": _id],
                   encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                print(response)
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    print(jsonData)
                    let user = self.makeItem(jsonItem: jsonData["response"])
                    print("Found utilisateur --------------------")
                    print(user)
                    print("-------------------------------")
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    print("-------5555----55")
                    completed(false, nil)
                }
            }
    }
    func ChangeProfilePic(id: String, uiImage: UIImage, completed: @escaping (Bool) -> Void){
                    AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
       
                    },to: Constant.host + "api/user/changeprofile/pic/"+id,
                      method: .post)
                .validate(statusCode: 200..<300)
                .responseData { response in
                    switch response.result {
                    case .success:
                        print("Success")
                        completed(true)
                    case let .failure(error):
                        completed(false)
                        print(error)
                    }
                }
        }
    
    //email: String,
    
    
    func changerPhotoDeProfil(email: String, uiImage: UIImage, completed: @escaping (Bool) -> Void ) {
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
            
            for (key, value) in
                    [
                        "email": email,
                    ]
            {
                multipartFormData.append((value.data(using: .utf8))!, withName: key)
            }
            
        },to: Constant.host + "utilisateur/photo-profil",
                  method: .post)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Success")
                    completed(true)
                case let .failure(error):
                    completed(false)
                    print(error)
                }
            }
    }
    
    
    
    
//    func changerPhotoDeProfil( uiImage: UIImage,user : User, completed: @escaping (Bool) -> Void ) {
//
//        AF.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
//
//        },to: Constant.host + "api/user/register",
//                  method: .post)
//            .validate(statusCode: 200..<300)
//            .validate(contentType: ["application/json"])
//            .responseData { response in
//                switch response.result {
//                case .success:
//                    print("Success")
//                    completed(true)
//                case let .failure(error):
//                    completed(false)
//                    print(error)
//                }
//            }
//    }
    
    
    func motDePasseOublie(email: String, codeDeReinit: String, completed: @escaping (Bool) -> Void) {
        AF.request(Constant.host + "api/user/motDePasseOublie",
                   method: .post,
                   parameters: ["email": email, "codeDeReinit": codeDeReinit])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func changerMotDePasse(email: String, nouveauMotDePasse: String, completed: @escaping (Bool) -> Void) {
        AF.request(Constant.host + "api/user/changerMotDePasse",
                   method: .put,
                   parameters: ["email": email,"nouveauMotDePasse": nouveauMotDePasse])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    
    
    
    func recupererToutUtilisateur( completed: @escaping (Bool, [User]?) -> Void ) {
        AF.request(Constant.host + "api/user/showAll",
                   method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    var utilisateurs : [User]? = []
                    for singleJsonItem in JSON(response.data!)["response"] {
                        utilisateurs!.append(self.makeItem(jsonItem: singleJsonItem.1))
                    }
                    completed(true, utilisateurs)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    
    func manipulerUtilisateur(utilisateur: User, methode: HTTPMethod, completed: @escaping (Bool) -> Void) {
        print(utilisateur)
        AF.request(Constant.host + "api/user/updateProfile",
                   method: .put,
                   parameters: [
                    "_id":utilisateur._id!,
                    "firstname": utilisateur.firstname!,
                    "lastname": utilisateur.lastname!,
                   ])
            .response { response in
                print(response)
            }
    }
    
    
    
    func makeItem(jsonItem: JSON) -> User {
        
        
        return User(
            _id: jsonItem["_id"].stringValue,
            firstname: jsonItem["firstname"].stringValue,
            lastname: jsonItem["lastname"].stringValue,
            email: jsonItem["email"].stringValue,
            password: jsonItem["password"].stringValue,
            pictureId: jsonItem["pictureId"].stringValue,
            isVerified: jsonItem["isVerified"].boolValue
        )
    }
    
    
    
    
    
//
//    func changerPhotoDeProfil( uiImage: UIImage, completed: @escaping (Bool) -> Void ) {
//
//        AF.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
//
////            for (key, value) in
////                    [
////                        "email": email,
////                    ]
////            {
////                multipartFormData.append((value.data(using: .utf8))!, withName: key)
////            }
//
//        },to: Constant.host  + "user/one",
//                  method: .post)
//            .validate(statusCode: 200..<300)
//            .validate(contentType: ["application/json"])
//            .responseData { response in
//                switch response.result {
//                case .success:
//                    print("Success")
//                    completed(true)
//                case let .failure(error):
//                    completed(false)
//                    print(error)
//                }
//            }
//    }



//    func connexion(email: String, password: String, completed: @escaping (Bool, Any?) -> Void) {
//            AF.request(Constant.host + "api/authentification/login",
//                       method: .post,
//                       parameters: ["email": email, "password": password])
//                .validate(statusCode: 200..<300)
//                .validate(contentType: ["application/json"])
//                .responseData { response in
//                    switch response.result {
//                    case .success:
//                        let jsonData = JSON(response.data!)
//
//                        let user = self.makeItem(jsonItem: jsonData["existingUser"])
//                        UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "tokenConnexion")
//                        UserDefaults.standard.setValue(user._id, forKey: "_id")
//                        UserDefaults.standard.setValue(user.password, forKey: "password")
//                        UserDefaults.standard.setValue(user.email, forKey: "email")
//                        UserDefaults.standard.setValue(user.nom, forKey: "firstname")
//
//                       // print(user)
//
//                        completed(true, user)
//                    case let .failure(error):
//                        debugPrint(error)
//                        completed(false, nil)
//                    }
//                }
//        }
//
//
//
//
//    func register(nom: String,prenom: String,email: String, password: String, idPhoto: UIImage, completed: @escaping (Bool, Any?) -> Void) {
//            AF.request(Constant.host + "api/authentification/register",
//                       method: .post,
//                       parameters: ["firstname": nom,"lastname": prenom,"email": email, "password": password, "pictureId": idPhoto])
//                .validate(statusCode: 200..<300)
//                .validate(contentType: ["application/json"])
//                .responseData { response in
//                    switch response.result {
//                    case .success:
//                        let jsonData = JSON(response.data!)
//
//                        let user = self.makeItem(jsonItem: jsonData["existingUser"])
//                        UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "token")
//                        UserDefaults.standard.setValue(user._id, forKey: "_id")
//                        UserDefaults.standard.setValue(user.nom, forKey: "firstname")
//                        UserDefaults.standard.setValue(user.prenom, forKey: "lastname")
//                        UserDefaults.standard.setValue(user.email, forKey: "email")
//                        UserDefaults.standard.setValue(user.password, forKey: "password")
//                        UserDefaults.standard.setValue(user.idPhoto, forKey: "pictureId")
//
//
//
//                       // print(user)
//
//                        completed(true, user)
//                    case let .failure(error):
//                        debugPrint(error)
//                        completed(false, nil)
//                    }
//                }
//
//        AF.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(idPhoto.jpegData(compressionQuality: 0.5)!, withName: "picture" , fileName: "image.png", mimeType: "image/png")
//
//        },to: Constant.host + "user/one",
//                  method: .post)
//            .validate(statusCode: 200..<300)
//            .validate(contentType: ["application/json"])
//            .responseData { response in
//                switch response.result {
//                case .success:
//                    print("Success")
//                case let .failure(error):
//                    completed(false, nil)
//                    print(error)
//                }
//            }
//        }
//    //email: String,
//
//    func changerPhotoDeProfil( uiImage: UIImage, completed: @escaping (Bool) -> Void ) {
//
//        AF.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "picture" , fileName: "image.png", mimeType: "image/png")
//
////            for (key, value) in
////                    [
////                        "email": email,
////                    ]
////            {
////                multipartFormData.append((value.data(using: .utf8))!, withName: key)
////            }
//
//        },to: Constant.host + "user/one",
//                  method: .post)
//            .validate(statusCode: 200..<300)
//            .validate(contentType: ["application/json"])
//            .responseData { response in
//                switch response.result {
//                case .success:
//                    print("Success")
//                    completed(true)
//                case let .failure(error):
//                    completed(false)
//                    print(error)
//                }
//            }
//    }
//
//    func recupererUtilisateurParToken(_id: String, completed: @escaping (Bool, User?) -> Void ) {
//        print("Looking for user --------------------")
//        print(_id)
//        AF.request(Constant.host + "user/one",
//                   method: .get,
//                   parameters: ["_id": _id],
//                encoding: JSONEncoding.default)
//            .validate(statusCode: 200..<300)
//            .validate(contentType: ["application/json"])
//            .response { response in
//                switch response.result {
//                case .success:
//                    let jsonData = JSON(response.data!)
//                    let user = self.makeItem(jsonItem: jsonData["user"])
//                    print("Found utilisateur --------------------")
//                    print(_id)
//                    print(user)
//                    print("-------------------------------")
//                    completed(true, user)
//                case let .failure(error):
//                    debugPrint(error)
//                    completed(false, nil)
//                }
//            }
//    }
//
//
//    func makeItem(jsonItem: JSON) -> User {
//        return User(
//            _id: jsonItem["_id"].stringValue,
//            nom: jsonItem["firstname"].stringValue,
//            prenom: jsonItem["lastname"].stringValue,
//            email: jsonItem["email"].stringValue,
//            password: jsonItem["password"].stringValue,
//            idPhoto: jsonItem["pictureId"].stringValue
//
//        )
//    }
}

