//
//  SignInViewModel.swift
//  SwiftNewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation

final class SignInViewModel: ObservableObject {
    
    var dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }

}
