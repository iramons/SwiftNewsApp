//
//  AuthCoordinator.swift
//  Swift-NewsApp
//
//  Created by Mac on 07/03/21.
//

import Swinject
import UIKit

enum AuthChildCoordinator {
    case about
}

final class AuthCoordinator: Coordinator, CoordinatorFinishOutput {
    // MARK: - CoordinatorFinishOutput
    var finishFlow: (() -> Void)?

    // MARK: - Vars & Lets
    let navigationController: UINavigationController
    let container: Container
    private var childCoordinators = [AuthChildCoordinator: Coordinator]()

    // MARK: - Coordinator
    func start() {
        showLoginVC()
    }

    // MARK: - Init
    init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
    }

    // MARK: - Private methods
    private func showLoginVC() {
        let vc = container.resolveViewController(SigninViewController.self)
        vc.onBack = { [unowned self] in
            self.navigationController.popVC()
        }
        vc.onLogin = {
            self.finishFlow?()
        }
        vc.onSignUp = {
            self.showSignUpVC()
        }

        navigationController.pushViewController(vc, animated: true)
    }

    private func showSignUpVC() {
        let vc = container.resolve(SigninViewController.self)
        vc?.onBack = { [unowned self] in
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        vc?.onSignUp = {
            self.navigationController.dismiss(animated: true, completion: nil)
        }
//        vc.onSignIn = {
//            self.navigationController.dismiss(animated: true, completion: nil)
//        }
        navigationController.present(vc!, animated: true, completion: nil)
    }
}
