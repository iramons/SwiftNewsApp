//
//  JSONDecoderExtensions.swift
//  Swift-NewsApp
//
//  Created by Mac on 06/03/21.
//

import Foundation
import Alamofire

extension JSONDecoder {
    
    func decodeError<T:Decodable>(response: AFDataResponse<T>) -> String {
        let decoder = JSONDecoder()
        var message = ""
        if let jsonData = response.data {
            let result = try! decoder.decode(ErrorResult.self, from: jsonData)
            message = result.message ?? "Algo deu errado!"
        }
        return message
    }
    
}
