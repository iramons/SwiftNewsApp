//
//  NewsResult.swift
//  Swift-NewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation

struct NewsResult: Codable {
    
    var pagination: Pagination?
    let data: [News]?
    
}
