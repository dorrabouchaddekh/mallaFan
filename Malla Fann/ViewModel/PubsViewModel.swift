//
//  PubsViewModel.swift
//  Malla Fann
//
//  Created by dorra on 26/4/2022.
//

import Foundation
import SwiftyJSON
import Alamofire


public class PubsViewModel: ObservableObject{

func SearchPubs(text:String, completed:@escaping (Bool,[Publication]?) -> Void) {
    AF.request(Constant.host+"api/publication/search", method: .post,parameters: ["text": text], encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData{
            response in
            switch response.result{
            case .success:
                let jsonData = JSON(response.data!)
                
                
                var publications : [Publication]? = []
                for singleJsonItem in jsonData["posts"] {
                    print(self.makeItem(jsonItem: singleJsonItem.1).title)
                    publications!.append(self.makeItem(jsonItem: singleJsonItem.1))
                }
                
                completed(true,publications)
                
                
            case let .failure(error) :
                debugPrint(error)
                completed(false, nil)
            }
        }
}

func makeItem(jsonItem: JSON) -> Publication {
    return Publication(
        _id: jsonItem["_id"].stringValue,
        title: jsonItem["title"].stringValue,
        description: jsonItem["description"].stringValue,
        categoriedata: jsonItem["categoriedata"].stringValue,
        photo: jsonItem["photo"].stringValue,
        nbrPhotos: jsonItem["nbrPhotos"].stringValue,
        video: jsonItem["video"].stringValue,
        audio: jsonItem["audio"].stringValue,
        enchere: jsonItem["enchere"].stringValue

    )
}
}
