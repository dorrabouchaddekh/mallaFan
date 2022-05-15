//
//  LinkViewModel.swift
//  Malla Fann
//
//  Created by dorra on 14/5/2022.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage
import Foundation
import UIKit

class LinkViewModel {
    static let sharedInstance = LinkViewModel()
    
    
    func addLink(title: String,_id:String,url:String, completed: @escaping (Bool,Any?) -> Void ) {
        AF.request(Constant.host + "api/link/add",
                   method: .post,
                   parameters: [
                    "_id":_id,
                    "title": title,
                    "url":url
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let link = self.makeLink(jsonItem: jsonData["links"])
                    
                    print("************************hhhhhh****************")
                    print(_id)
                    UserDefaults.standard.string(forKey: "_id")

                    completed(true,link)
                case let .failure(error):
                    debugPrint(error)
                    completed(false,nil)
                }
            }
    }
    
    
    func getLinksByUserId(_id : String,completed: @escaping (Bool,[Link]?) -> Void){
        AF.request(Constant.host + "api/link/getLinksByUserId",method: .post,parameters: ["_id":_id],encoding: JSONEncoding.default)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .success:
                        let jsonData = JSON(response.data!)
                        var links : [Link]? = []
                        for singleJsonItem in jsonData["links"] {
                            links!.append(self.makeLink(jsonItem: singleJsonItem.1))
                        }
                        completed(true, links)
                    case .failure:
                        completed(false, nil)
                    }
                }
        }
    
    
    func makeLink(jsonItem: JSON) -> Link {

        return Link(
            _id: jsonItem["_id"].stringValue,
            title: jsonItem["title"].stringValue,

            url: jsonItem["url"].stringValue,


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
