//
//  FeedsMO.swift
//  Swift-NewsApp
//
//  Created by Mac on 06/03/21.
//

import Foundation
import CoreData

@objc(NewsMO)
final class NewsMO: NSManagedObject {
    @NSManaged var uuid: UUID?
    @NSManaged var title: String
    @NSManaged var feedDescription: String
    @NSManaged var content: String
    @NSManaged var author: String
    @NSManaged var publishedAt: String
    @NSManaged var highlight: Bool
    @NSManaged var url: String
    @NSManaged var imageURL: String
}

extension NewsMO {
    func convertToNews() -> News {
        News(
            id: UUID(),
            title: title,
            feedDescription: feedDescription,
            content: content,
            author: author,
            publishedAt: publishedAt,
            highlight: highlight,
            url: url,
            imageURL: imageURL
        )
    }
}
