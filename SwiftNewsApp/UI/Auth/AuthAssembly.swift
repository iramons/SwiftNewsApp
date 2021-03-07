//
//  AuthAssembly.swift
//  SwiftNewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation
import Swinject

final class AuthAssembly: Assembly {
    func assemble(container: Container) {

        container.register(UserService.self, factory: { _ in
            UserService()
        }).inObjectScope(ObjectScope.container)

//                container.register(MoyaProvider<AuthService>.self, factory: { _ in
//            MoyaProvider<AuthService>(plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter),
//                                                                                         logOptions: .verbose))])
//        }).inObjectScope(ObjectScope.container)

//        container.register(SignInViewModel.self, factory: { container in
//            SignUpViewModel(service: container.resolve(MoyaProvider<AuthService>.self)!)
//        }).inObjectScope(ObjectScope.container)

//        container.register(LogInViewModel.self, factory: { container in
//            LogInViewModel(service: container.resolve(MoyaProvider<AuthService>.self)!, userService: container.resolve(UserService.self)!)
//        }).inObjectScope(ObjectScope.container)

        // view controllers
        container.storyboardInitCompleted(SigninViewController.self) { r, c in
//            c.viewModel = r.resolve(SignInViewModel.self)
        }
//        container.storyboardInitCompleted(SignUpVC.self) { r, c in
//            c.signUpViewModel = r.resolve(SignUpViewModel.self)
//        }
    }
}
