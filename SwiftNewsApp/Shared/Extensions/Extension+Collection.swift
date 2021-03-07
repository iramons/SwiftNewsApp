//
//  Extension+Collection.swift
//  SwiftNewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Dictionary {
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
}

extension Dictionary where Key == String {
    var isSuccess: Bool {
        if let error = self["error"] as? Bool {
            return error
        } else {
            return true
        }
    }

    var data: Data? {
        return (self["data"] as? String)?.data(using: .utf8)
    }

    var message: String? {
        return self["message"] as? String
    }
}
