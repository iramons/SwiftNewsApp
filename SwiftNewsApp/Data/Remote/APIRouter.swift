//
//  APIRouter.swift
//  Swift-NewsApp
//
//  Created by Mac on 06/03/21.
//

import Foundation
import Alamofire

enum APIRouter: APIConfiguration {

    case signin(email: String, password: String)
    case getHighlights
    case getNews(currentPage: Int, perPage: Int, publishedAt: String)

    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
            
        case .signin:
            return .post
            
        case .getHighlights,
             .getNews:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        
        case .signin:
            return "/v1/client/auth/signin"

        case .getHighlights:
            return "/v1/client/news/highlights"
            
        case .getNews:
            return "/v1/client/news"
        }
    }
    
    // MARK: - Parameters
    var parameters: RequestParams {
        switch self {
        
        case .signin(let email, let password):
        return .body([Constants.APIParamKeys.email: email,
                      Constants.APIParamKeys.password: password])
        
        case .getHighlights:
            return .url([:])
            
        case .getNews(let currentPage, let perPage, let publishedAt):
            return .url([Constants.APIParamKeys.currentPage: currentPage,
                         Constants.APIParamKeys.perPage: perPage,
                         Constants.APIParamKeys.publishedAt: publishedAt])

        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
                
        let url = try APIEnvironment.Production.baseURL.asURL()
    
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.timeoutInterval = 30

        /// HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6NTQxLCJlbWFpbCI6InRlYnJhbS5kZXZAZ21haWwuY29tIn0.FtrbPE6ebeubFDV4ocuI5T3VmgQbzSuledKAUFhZLNE"
//        let accessToken = Helper.app.getAccessToken()

        /// Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)

        // Parameters
        switch parameters {
            
        case .body(let params):
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            
        case .url(let params):
                let queryParams = params.map { pair in
                    return URLQueryItem(name: pair.key, value: "\(pair.value)")
                }
                var components = URLComponents(string:url.appendingPathComponent(path).absoluteString)
                components?.queryItems = queryParams
                urlRequest.url = components?.url
        }
        
        return urlRequest
    }
        
}
 


