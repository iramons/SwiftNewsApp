//
//  User.swift
//  SwiftNewsApp
//
//  Created by Mac on 07/03/21.
//

import SwiftyJSON

class User: Codable {

    var email: String!
    var accessToken: String!
    
    init() {}
    
    init(fromJson json: JSON!) {
       if json.isEmpty {
           return
       }
       email = json["email"].stringValue
       accessToken = json["access_token"].stringValue
    }

   /**
    * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
    */
   func toDictionary() -> [String: Any] {
       var dictionary = [String: Any]()
       if email != nil {
           dictionary["email"] = email
       }
       if accessToken != nil {
           dictionary["accessToken"] = accessToken
       }
       return dictionary
   }
}
