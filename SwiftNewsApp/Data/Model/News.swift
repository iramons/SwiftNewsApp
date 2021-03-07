//
//  Feeds.swift
//  Swift-NewsApp
//
//  Created by Mac on 06/03/21.
//

import Foundation

struct News: Codable {
    
    var id: UUID?
    let title: String?
    let feedDescription: String?
    let content: String?
    let author: String?
    let publishedAt: String?
    let highlight: Bool?
    let url: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case title
        case feedDescription = "description"
        case content, author
        case publishedAt = "published_at"
        case highlight, url
        case imageURL = "image_url"
    }
    
}

extension News {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(News.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        title: String?? = nil,
        feedDescription: String?? = nil,
        content: String?? = nil,
        author: String?? = nil,
        publishedAt: String?? = nil,
        highlight: Bool?? = nil,
        url: String?? = nil,
        imageURL: String?? = nil
    ) -> News {
        return News(
            title: title ?? self.title,
            feedDescription: feedDescription ?? self.feedDescription,
            content: content ?? self.content,
            author: author ?? self.author,
            publishedAt: publishedAt ?? self.publishedAt,
            highlight: highlight ?? self.highlight,
            url: url ?? self.url,
            imageURL: imageURL ?? self.imageURL
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    return encoder
}

