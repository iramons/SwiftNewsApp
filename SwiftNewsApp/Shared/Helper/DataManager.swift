//
//  DataManager.swift
//  Swift-NewsApp
//
//  Created by Mac on 06/03/21.
//

import Foundation
import CoreData

import Foundation

protocol DataManagerProtocol {
    func initFetchHighlights(complete completion: @escaping (Result<HighlightsResult, Error>) -> Void)
    func initFetchNews(currentPage: Int, perPage: Int, publishedAt: String, complete completion: @escaping (Result<NewsResult, Error>) -> Void)

    func getFeeds(currentPage: Int, perPage:Int, publishedAt: String) -> [News]
    func saveToDB(item: News)
    func insertNews(id: UUID, title: String, feedDescription: String, content: String, author: String, publishedAt: String, highlight: Bool, url: String, imageURL: String)
}

extension DataManagerProtocol {
    func fetchNewsList(currentPage: Int, perPage:Int, publishedAt: String) -> [News] {
        getFeeds(currentPage: currentPage, perPage:perPage, publishedAt: publishedAt)
    }
}

class DataManager {
    static let shared: DataManagerProtocol = DataManager()
    private var highlights = [Highlight]()
    private var news = [News]()
    private init() { }
}

extension DataManager: DataManagerProtocol {
    
    func initFetchHighlights(complete completion: @escaping (Result<HighlightsResult, Error>) -> Void) {
        
        let future = APIClient.getHighlights()

        future.execute(onSuccess: { response in
            completion(.success(response))
            DispatchQueue.main.async {
                response.data?.forEach { item in
                    self.saveToDB(item: item)
                }
            }
        
        }, onFailure: {error in
            completion(.failure(error))
            DispatchQueue.main.async {
                self.getDbInfo{ result in
//                    completion(.success( try! result.get()))
                }
            }
        })
    }
    

    func initFetchNews(currentPage: Int, perPage: Int, publishedAt: String, complete completion: @escaping (Result<NewsResult, Error>) -> Void) {
        let future = APIClient.getNews(currentPage: currentPage, perPage: perPage, publishedAt: publishedAt)

        future.execute(onSuccess: { response in
            completion(.success(response))
            DispatchQueue.main.async {
                response.data?.forEach { item in
                    self.saveToDB(item: item)
                }
            }
        
        }, onFailure: {error in
            completion(.failure(error))
            DispatchQueue.main.async {
                self.getDbInfo{ result in
//                    completion(.success( try! result.get()))
                }
            }
        })
    }
    
    
    func getFeeds(currentPage: Int, perPage: Int, publishedAt: String) -> [News] {
        return news
    }
    
    private func getDbInfo(complete completion: @escaping (Result<[News], APIError>) -> Void) {
//        let results = dbContainer?.values(
//            APIMeteorite.self,
//            matching:nil
//        )
        completion(.success(news))
    }

    
    func getNewsListFromDB() -> [News] {
        return news
    }
    
    func saveToDB(item: News) {
        news.insert(item, at: 0)
    }
    
    func saveToDB(item: Highlight) {
        highlights.insert(item, at: 0)
    }
    
    func insertNews(id: UUID, title: String, feedDescription: String, content: String, author: String, publishedAt: String, highlight: Bool, url: String, imageURL: String) {
        let item = News(id: id, title: title, feedDescription: feedDescription, content: content, author: author, publishedAt: publishedAt, highlight: highlight, url: url, imageURL: imageURL
        )
        news.insert(item, at: 0)
    }
}
