//
//  FeedCoordinator.swift
//  Swift-NewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation
import Swinject


final class FeedCoordinator: Coordinator, CoordinatorFinishOutput {
    // MARK: - CoordinatorFinishOutput
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    let container: Container
    let navigationController: UINavigationController
//    private var childCoordinators = [AppCoordinator: Coordinator]()

    // MARK: - Coordinator
    func start() {
        showFeedViewController()
    }

    // MARK: - Init
    init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
    }

    // MARK: - Private metods
    private func showFeedViewController() {
        let vc = container.resolveViewController(FeedViewController.self)
        vc.onSignOut = {
            self.finishFlow?()
        }
        navigationController.pushViewController(vc, animated: true)
    }

}
