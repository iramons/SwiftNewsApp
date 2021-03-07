//
//  FeedCoordinator.swift
//  Swift-NewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation
import Swinject

enum FeedChildCoordinator {
    case about
}

final class FeedCoordinator: Coordinator, CoordinatorFinishOutput {
    // MARK: - CoordinatorFinishOutput

    var finishFlow: (() -> Void)?
    let container: Container

    // MARK: - Vars & Lets

    let navigationController: UINavigationController
    private var childCoordinators = [FeedChildCoordinator: Coordinator]()

    // MARK: - Coordinator

    func start() {
        showHomeVC()
    }

    // MARK: - Init

    init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
    }

    // MARK: - Private metods

    private func showHomeVC() {
        let vc = container.resolve(FeedViewController.self)
        vc?.onSignOut = {
            self.finishFlow?()
        }
//        vc.onBookSelected = { viewModel in
//            self.showBookDetailVC(viewModel: viewModel)
//        }
        
        navigationController.pushViewController(vc!, animated: true)
    }

    private func showBookDetailVC(viewModel: FeedViewModel) {
        let vc = container.resolve(FeedViewController.self)
        vc?.viewModel = viewModel

//        vc.onBack = { [unowned self] in
//            self.navigationController.popVC()
//        }
        navigationController.pushViewController(vc!, animated: true)
    }
}
