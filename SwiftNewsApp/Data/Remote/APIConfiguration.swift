//
//  APIConfiguration.swift
//  Swift-NewsApp
//
//  Created by Mac on 06/03/21.
//

import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
}
