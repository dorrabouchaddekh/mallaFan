


import SwiftyJSON
import Alamofire
import UIKit.UIImage
import Foundation
import UIKit

class PublicationViewModel {
    
    static let sharedInstance = PublicationViewModel()
    
    func recupererToutPublication(  completed: @escaping (Bool, [Publicationn]?) -> Void ) {
        AF.request(Constant.host + "api/publication/getAll",
                   method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    
                    var publications : [Publicationn]? = []
                    for singleJsonItem in jsonData["posts"] {
                        publications!.append(self.makePublicationn(jsonItem: singleJsonItem.1))
                    }
                    completed(true, publications)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    
    func recupererCinqPublication(  completed: @escaping (Bool, [Publicationn]?) -> Void ) {
        AF.request(Constant.host + "api/publication/showFirstFive",
                   method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    
                    var publications : [Publicationn]? = []
                    for singleJsonItem in jsonData[] {
                        publications!.append(self.makePublicationn(jsonItem: singleJsonItem.1))
                    }
                    completed(true, publications)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func recupererPublicationParUtilisateur(_id: String, completed: @escaping (Bool, [Publicationn]?) -> Void ) {
        AF.request(Constant.host + "publication/mes",
                   method: .post,
                   parameters: [
                    "user": _id
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    
                    var publications : [Publicationn]? = []
                    for singleJsonItem in jsonData["posts"] {
                        publications!.append(self.makePublicationn(jsonItem: singleJsonItem.1))
                    }
                    completed(true, publications)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func recupererPublicationParId(_id: String, completed: @escaping (Bool, Publicationn?) -> Void ) {
        print(_id)
        print("Looking for publication --------------------")
        AF.request(Constant.host + "api/publication/show",
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
                    UserDefaults.standard.string(forKey: "_id")
                    let publicationn = self.makePublicationn(jsonItem: jsonData["response"])
                    print("Found utilisateur --------------------")
                    print(publicationn)
                    print("-------------------------------")
                    completed(true, publicationn)
                case let .failure(error):
                    debugPrint(error)
                    print("-------5555----55")
                    completed(false, nil)
                }
            }
    }
    
    
    
    
    func ajouterPublication(publication: Publicationn, videoUrl: UIImage, completed: @escaping (Bool,Publicationn?) -> Void ) {
        
        AF.upload(multipartFormData: { multipartFormData in
            
            do {
                
                multipartFormData.append(videoUrl.jpegData(compressionQuality: 0.5)!, withName: "imagee" , fileName: "imagee.jpeg", mimeType: "imagee/jpeg")
                //  here you can see data bytes of selected video, this data object is upload to server by multipartFormData upload
            } catch  {
            }
            
        },to: Constant.host + "api/publication/add",
                  method: .post)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Success")
                    let jsonData = JSON(response.data!)
                    let publicationn = self.makePublicationn(jsonItem: jsonData["post"])
                    
                    completed(true, publicationn)
                case let .failure(error):
                    completed(false, nil)
                    print(error)
                }
            }
    }
    
    


    

    func modifierPublication(description: String,_id:String,pubId:String, completed: @escaping (Bool,Any?) -> Void ) {
        AF.request(Constant.host + "api/publication/addPub",
                   method: .post,
                   parameters: [
                    "_id":_id,
                    "description": description,
                    "pubId":pubId
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let publicationn = self.makePublicationn(jsonItem: jsonData["posts"])
                    let user = self.makeUtilisateur(jsonItem: jsonData["use"])
                    
                    print("************************hhhhhh****************")
                    print(_id)
                    UserDefaults.standard.string(forKey: "_id")
                    UserDefaults.standard.setValue(publicationn._id, forKey: "_id")
                    completed(true,publicationn)
                case let .failure(error):
                    debugPrint(error)
                    completed(false,nil)
                }
            }
    }
    
    
    
    
    
    func supprimerPublication(_id: String?, completed: @escaping (Bool) -> Void ) {
        AF.request(Constant.host + "publication/",
                   method: .delete,
                   parameters: [
                    "_id": _id!
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true)
                case let .failure(error):
                    debugPrint(error)
                    completed(false)
                }
            }
    }
    
    func report(_id: String?, type: String, completed: @escaping (Bool) -> Void ) {
        AF.request(Constant.host + "publication/report",
                   method: .post,
                   parameters: [
                    "_id": _id!,
                    "type" : type,
                    "user" : UserDefaults.standard.string(forKey: "_id")!
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true)
                case let .failure(error):
                    debugPrint(error)
                    completed(false)
                }
            }
    }
    
    func GetVideosByUser(_id : String,completed: @escaping (Bool,[Publicationn]?) -> Void){
        AF.request(Constant.host + "api/publication/GetVideoByUser",method: .post,parameters: ["_id":_id],encoding: JSONEncoding.default)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .success:
                        let jsonData = JSON(response.data!)
                        var publications : [Publicationn]? = []
                        for singleJsonItem in jsonData["posts"] {
                            publications!.append(self.makePublicationn(jsonItem: singleJsonItem.1))
                        }
                        completed(true, publications)
                    case .failure:
                        completed(false, nil)
                    }
                }
        }
    
    
    
    
    
    
    
    
    func makePublicationn(jsonItem: JSON) -> Publicationn {

        return Publicationn(
            _id: jsonItem["_id"].stringValue,
            description: jsonItem["description"].stringValue,
            date: Date(),

            pictureId: jsonItem["pictureId"].stringValue,


            utilisateur: makeUtilisateur(jsonItem: jsonItem["utilisateur"])

        )
    }
    
    func makeUtilisateur(jsonItem: JSON) -> User {
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
