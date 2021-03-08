//
//  SignInViewModel.swift
//  SwiftNewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

final class SignInViewModel: ObservableObject {
    
    var dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
    
    let loading = BehaviorRelay<Bool>(value: false)
    let success = BehaviorRelay<Bool>(value: false)
    let errorMessage = BehaviorRelay<String>(value: Constants.Errors.unexpectedError)
    
    func signIn(
        email: String,
        password: String
    ) {
        self.loading.accept(true)

        let future = APIClient.signIn(email: email, password: password)

        future.execute(onSuccess: { response in
            if response.token != nil {
                Helper.app.setAccessToken(s: response.token ?? "")
                UserService.shared.save(token: response.token ?? "")
                self.success.accept(true)
            }
            self.loading.accept(false)
            self.success.accept(false)
        }, onFailure: {error in
            self.loading.accept(false)
            self.success.accept(false)
        })
    }

}
