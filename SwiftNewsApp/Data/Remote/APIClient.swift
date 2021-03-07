//
//  APIClient.swift
//  Swift-NewsApp
//
//  Created by Marbet Ramon on 06/03/21.
//

import Foundation
import Alamofire
import PromisedFuture
import SwiftyJSON

enum APIError: String, Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
}

class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder()) -> Future<T,Error> {
        return Future(operation: { completion in
            AF.request(route)
                .responseDecodable ( decoder: decoder, completionHandler: { (response: AFDataResponse<T>) in
        
                    let statusCode = response.response?.statusCode

                    switch response.result {
                        case .success(let value):
                            switch statusCode {
                                
                                case 200:
                                    completion(.success(value))
                                    break
                                    
                                ///verificar, pois em alguns casos terá que tomar ações diferentes
                                case 201:
                                    completion(.success(value))
                                    break

                                ///verificar, pois em alguns casos terá que tomar ações diferentes
                                case 204:
                                    completion(.success(value))
                                    break

                                case 400,
                                     401,
                                     403,
                                     404,
                                     405:
                                    decoder.decodeError(response: response)
                                    completion(.success(value))
                                    break
                                    
                                default:
                                    completion(.success(value))
                                    break
                            }
                            
                        case .failure(let error):
                            switch statusCode {
                            case 401:
//                                callRefreshToken()
                                decoder.decodeError(response: response)
                                completion(.failure(error))
                                break
                            
                            case 404:
                                //recurso não encontrado
                                decoder.decodeError(response: response)
                                completion(.failure(error))
//                                Switcher.updateRootVC()
                                break
                                
                            default:
                                decoder.decodeError(response: response)
                                completion(.failure(error))
                                break
                            }
                    }
                })
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        print("API Success Response: \(json)")
                    case .failure(let error):
                        print("API Error Response: \(error)")
                    }
            }
        })
    }
    
    static func getHighlights() -> Future<HighlightsResult, Error> {
        performRequest(route: APIRouter.getHighlights)
    }
    
    static func getNews(currentPage: Int, perPage: Int, publishedAt: String) -> Future<NewsResult, Error> {
        performRequest(route: APIRouter.getNews(currentPage: currentPage, perPage: perPage, publishedAt: publishedAt))
    }
    
}
