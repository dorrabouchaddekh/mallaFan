//
//  EventViewModel.swift
//  Malla Fann
//
//  Created by dorra on 18/5/2022.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage
import Foundation
import UIKit

class EventViewModel {
    
    static let sharedInstance = EventViewModel()
    
    
    func addEvent(name: String,date: Date,startDate: String,longitude: Double,latitude: Double,_id:String,eventId:String, completed: @escaping (Bool,Any?) -> Void ) {
        AF.request(Constant.host + "api/event/addEvent",
                   method: .post,
                   parameters: [
                    "_id":_id,
                    "name": name,
                    "date": date,
                    "startDate":startDate,
                    "longitude":longitude,
                    "latitude":latitude,
                    "eventId":eventId
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)

                    let event = self.makeEvent(jsonItem: jsonData["events"])
                    let user = self.makeUtilisateur(jsonItem: jsonData["use"])
                    
                    print("************************hhhhhh****************")
                    print(_id)
                    UserDefaults.standard.string(forKey: "_id")
                    print("Location captured!")
                    completed(true,event)
                case let .failure(error):
                    debugPrint(error)
                    completed(false,nil)
                }
            }
    }
    
    func recupererToutEvent(  completed: @escaping (Bool, [Event]?) -> Void ) {
        AF.request(Constant.host + "api/event/getAll",
                   method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    
                    var eventts : [Event]? = []
                    for singleJsonItem in jsonData["events"] {
                        eventts!.append(self.makeEvent(jsonItem: singleJsonItem.1))
                    }
                    completed(true, eventts)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    
    
    
    func GetVideosByUser(_id : String,completed: @escaping (Bool,[Event]?) -> Void){
        AF.request(Constant.host + "api/event/GetVideoByUser",method: .post,parameters: ["_id":_id],encoding: JSONEncoding.default)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .success:
                        let jsonData = JSON(response.data!)
                        var events : [Event]? = []
                        for singleJsonItem in jsonData["events"] {
                            events!.append(self.makeEvent(jsonItem: singleJsonItem.1))
                        }
                        completed(true, events)
                    case .failure:
                        completed(false, nil)
                    }
                }
        }
    
    
    func ajouterEvent(eventt: Event, videoUrl: UIImage, completed: @escaping (Bool,Event?) -> Void ) {
        
        AF.upload(multipartFormData: { multipartFormData in
            
            do {
                
                multipartFormData.append(videoUrl.jpegData(compressionQuality: 0.5)!, withName: "imagee" , fileName: "imagee.jpeg", mimeType: "imagee/jpeg")
                //  here you can see data bytes of selected video, this data object is upload to server by multipartFormData upload
            } catch  {
            }
            
        },to: Constant.host + "api/event/add",
                  method: .post)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Success")
                    let jsonData = JSON(response.data!)
                    let event = self.makeEvent(jsonItem: jsonData["event"])

                    completed(true, event)
                case let .failure(error):
                    completed(false, nil)
                    print(error)
                }
            }
    }
    
    
    func makeEvent(jsonItem: JSON) -> Event {
//        let isoDate = "2016-04-14T10:44:00+0000"
//
//        let dateFormatter = ISO8601DateFormatter()
//        let date = dateFormatter.date(from:jsonItem["date"].stringValue)
        return Event(
            _id: jsonItem["_id"].stringValue,
            name: jsonItem["name"].stringValue,
            
            date: DateUtils.formatFromString(string: jsonItem["date"].stringValue),
            startDate: jsonItem["createdAt"].stringValue,
            latitude: jsonItem["latitude"].doubleValue,
            longitude: jsonItem["longitude"].doubleValue,
            
            utilisateur: makeUtilisateur(jsonItem: jsonItem["utilisateur"]),
            pictureId: jsonItem["pictureId"].stringValue

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
