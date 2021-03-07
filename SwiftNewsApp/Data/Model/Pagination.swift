//
//  Pagination.swift
//  Swift-NewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation

struct Pagination: Codable {
    
    var currentPage: Int?
    let perPage: Int?
    let totalPages: Int?
    let totalItems: Int?
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case perPage = "per_page"
        case totalPages = "total_pages"
        case totalItems = "total_items"
    }

}
