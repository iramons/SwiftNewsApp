//
//  AppCoordinator.swift
//  Swift-NewsApp
//
//  Created by Mac on 07/03/21.
//

import Swinject
import UIKit

enum AppChildCoordinator {
    case auth
    case feed
}

final class AppCoordinator: Coordinator {

    private let window: UIWindow
    let container: Container

    private var launchInstructor: LaunchInstructor
    private var navigationController: UINavigationController
    private var childCoordinators = [AppChildCoordinator: Coordinator]()

    init(window: UIWindow, container: Container, navigationController: UINavigationController, launchInstructor: LaunchInstructor) {
        self.window = window
        self.container = container
        self.navigationController = navigationController
        self.launchInstructor = launchInstructor
        self.window.rootViewController = navigationController
    }

    func start() {
        switch launchInstructor {
            case .auth: runAuthFlow()
            case .feed: runFeedFlow()
        }
    }

    
    // MARK: - Private methods
    private func runAuthFlow() {
        let coordinator = AuthCoordinator(container: container, navigationController: navigationController)
        coordinator.finishFlow = { [unowned self] in
            self.childCoordinators[.auth] = nil
            self.launchInstructor = LaunchInstructor.configure(isAutorized: UserService.shared.isAuthenticated())
            self.navigationController.viewControllers.removeAll()
            self.start()
        }
        childCoordinators[.auth] = coordinator
        coordinator.start()
    }

    private func runFeedFlow() {
        let coordinator = FeedCoordinator(container: container, navigationController: navigationController)
        coordinator.finishFlow = { [unowned self] in
            self.childCoordinators[.feed] = nil
            self.launchInstructor = LaunchInstructor.configure(isAutorized: UserService.shared.isAuthenticated())
            self.navigationController.viewControllers.removeAll()
            self.start()
        }
        childCoordinators[.feed] = coordinator
        coordinator.start()
    }
}
