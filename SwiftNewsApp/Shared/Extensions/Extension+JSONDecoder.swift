//
//  JSONDecoderExtensions.swift
//  Swift-NewsApp
//
//  Created by Mac on 06/03/21.
//

import Foundation
import Alamofire

extension JSONDecoder {
    
    func decodeError<T:Decodable>(response: AFDataResponse<T>) -> ErrorResult {
        let decoder = JSONDecoder()
        var errorResult: ErrorResult?
        if let jsonData = response.data {
            let result = try! decoder.decode(ErrorResult.self, from: jsonData)
            errorResult = result
        }
        return errorResult ?? ErrorResult(code: "", message: "")
    }
    
}
