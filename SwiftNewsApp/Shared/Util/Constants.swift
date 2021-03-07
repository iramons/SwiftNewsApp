//
//  Constants.swift
//  Swift-NewsApp
//
//  Created by Mac on 06/03/21.
//

import Foundation
import Alamofire

struct Constants {

    //MARK: - Preferences keys
    struct Preferences {
        static let isUserLoggedIn = "isUserLoggedIn"
        static let accessToken = "accessToken"
        static let app = "app"
    }
    
    struct APIParamKeys {
        static let email = "email"
        static let password = "password"
        static let currentPage = "current_page"
        static let perPage = "per_page"
        static let publishedAt = "published_at"
    }
}

enum RequestParams {
    case body(_:Parameters)
    case url(_:Parameters)
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case culture = "Culture"
}

enum ContentType: String {
    case json = "application/json"
}

