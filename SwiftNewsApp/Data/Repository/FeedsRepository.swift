//
//  FeedsRepository.swift
//  Swift-NewsApp
//
//  Created by Mac on 06/03/21.
//

import Foundation

protocol FeedsRepositoryProtocol {
    func initFetch(complete completion: @escaping (Result<[News], APIError>) -> Void)
}

class FeedsRepository {
    
    var fetchData: (() -> ())?
    
    private let apiClient: APIClient
//    private var dbContainer: Container?
    
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
//        do {
////            self.dbContainer = try Container()
//        } catch let error {
////            Global.printToConsole(message: error.localizedDescription)
//        }
    }
    
    private func saveToDB(_ feeds: [News]) {
        
//        do {
//            try dbContainer?.write { transaction in
//                //TODO: Too much CPU, 13% CPU incraesed
//                feeds.forEach { item in
//                    transaction.add(item, update: .modified)
//                }
//            }
//        } catch (let error) {
////            Global.printToConsole(message: error.localizedDescription)
//        }
    }
    
    private func getDbInfo(complete completion: @escaping (Result<[News], APIError>) -> Void) {
        
//        let results = dbContainer?.values(
//            APIMeteorite.self,
//            matching:nil
//        )
//        completion(.success(results?.filter { $0.geolocation != nil } ?? []))
    }
}

extension FeedsRepository: FeedsRepositoryProtocol {
    
    func initFetch(complete completion: @escaping (Result<[News], APIError>) -> Void) {
        
//        apiClient.getNews(from: .listRecords) { [weak self] result in
//            switch result{
//
//            case .success(let meteorites):
//                completion(.success(meteorites))
//                DispatchQueue.main.async {
//                    self?.saveToDB(meteorites)
//                }
//
//            case .failure(let error):
//                completion(.failure(error))
//                DispatchQueue.main.async {
//                    self?.getDbInfo{ result in
//                        completion(.success( try! result.get()))
//                    }
//                }
//            }
//        }
    }
}
