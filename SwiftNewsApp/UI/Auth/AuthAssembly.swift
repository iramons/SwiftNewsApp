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

        // view model
        container.register(SignInViewModel.self, factory: { container in
            SignInViewModel()
        }).inObjectScope(ObjectScope.container)

        // view controllers
        container.storyboardInitCompleted(SignInViewController.self) { r, c in
            c.viewModel = r.resolve(SignInViewModel.self)
        }
    }
}
