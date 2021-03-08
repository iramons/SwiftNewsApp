//
//  AuthCoordinator.swift
//  Swift-NewsApp
//
//  Created by Mac on 07/03/21.
//

import Swinject
import UIKit


final class AuthCoordinator: Coordinator, CoordinatorFinishOutput {
    // MARK: - CoordinatorFinishOutput
    var finishFlow: (() -> Void)?

    // MARK: - Vars & Lets
    let navigationController: UINavigationController
    let container: Container
//    private var childCoordinators = [AuthChildCoordinator: Coordinator]()

    // MARK: - Coordinator
    func start() {
        showSignInViewController()
    }

    // MARK: - Init
    init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
    }

    private func showSignInViewController() {
        let vc = container.resolveViewController(SignInViewController.self)
        vc.onBack = { [unowned self] in
            self.navigationController.popVC()
        }
        vc.onSignIn = {
            self.finishFlow?()
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func showFeedViewController() {
        let vc = container.resolveViewController(FeedViewController.self)
        vc.onBack = { [unowned self] in
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        vc.onSignIn = {
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        navigationController.present(vc, animated: true, completion: nil)
    }

}
