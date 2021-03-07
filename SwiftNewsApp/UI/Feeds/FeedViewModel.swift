//
//  FeedsViewModel.swift
//  Swift-NewsApp
//
//  Created by Mac on 06/03/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol FeedsViewModelProtocol {
    func addNewNews(id: UUID, title: String, feedDescription: String, content: String, author: String, publishedAt: String, highlight: Bool, url: String, imageURL: String)
}

final class FeedViewModel: ObservableObject {
    
    var dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
    
    let highlights = BehaviorRelay(value: [Highlight]())
    var highlightsObservable: Observable<[Highlight]> {
        return highlights.asObservable()
    }
    
    let news = BehaviorRelay(value: [News]())
    var newsObservable: Observable<[News]> {
        return news.asObservable()
    }
    
    var showAlertClosure: (()->())?
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    private let isLogout = PublishSubject<Bool>()
    var onLogout: Observable<Bool> {
        return isLogout.asObservable().distinctUntilChanged()
    }
    
    func fetchHighlightsData() {
        dataManager.initFetchHighlights() { [weak self] result in
//            self?.isLoading = false
            switch result {
            case .success(let list):
                self?.highlights.accept(list.data ?? [])
            case .failure(let error):
                print("error == \(error)")
//                self?.processError(error: error)
            }
        }
    }
    
    func fetchNewsData(currentPage: Int, perPage:Int, publishedAt: String) {
        dataManager.initFetchNews(currentPage: currentPage, perPage: perPage, publishedAt: publishedAt){ [weak self] result in
//            self?.isLoading = false
            switch result {
            case .success(let list):
                self?.news.accept(list.data ?? [])
            case .failure(let error):
                print("error == \(error)")
//                self?.processError(error: error)
            }
        }
    }
    
    enum UserAlert:  String, Error {
        case userError = "Please make sure your network is working fine or re-launch the app"
        case serverError = "Please wait a while and re-launch the app"
    }
    
    private func processError(error:APIError) {
        switch error {
        case .clientError:
            self.alertMessage = UserAlert.userError.rawValue
            
        case .serverError,.noData,.dataDecodingError:
            self.alertMessage = UserAlert.serverError.rawValue
        }
    }
    
}

// MARK: - NewTodoViewModelProtocol
extension FeedViewModel: FeedsViewModelProtocol {
    
    var highlightCount: Int {
        self.highlights.value.count
    }
    
    var newsCount: Int {
        self.news.value.count
    }
    
    func addNewNews(id: UUID, title: String, feedDescription: String, content: String, author: String, publishedAt: String, highlight: Bool, url: String, imageURL: String) {
        dataManager.insertNews(id: id, title: title, feedDescription: feedDescription, content: content, author: author, publishedAt: publishedAt, highlight: highlight, url: url, imageURL: imageURL)
    }
}
