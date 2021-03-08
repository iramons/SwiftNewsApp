//
//  FeedAssembly.swift
//  SwiftNewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation
import Swinject

final class FeedAssembly: Assembly {
    func assemble(container: Container) {

        container.register(UserService.self, factory: { _ in
            UserService()
        }).inObjectScope(ObjectScope.container)

        // view model
        container.register(FeedViewModel.self, factory: { container in
            FeedViewModel()
        }).inObjectScope(ObjectScope.container)

        // view controllers
        container.storyboardInitCompleted(FeedViewController.self) { r, c in
            c.viewModel = r.resolve(FeedViewModel.self)
        }
    }
}
