//
//  SigninViewController.swift
//  Swift-NewsApp
//
//  Created by Mac on 07/03/21.
//

import RxCocoa
import RxSwift
import SwiftValidator
import Swinject
import UIKit

protocol SignInViewControllerProtocol: AnyObject {
    var onBack: (() -> Void)? { get set }
    var onSignIn: (() -> Void)? { get set }
    var onSignUp: (() -> Void)? { get set }
}

class SignInViewController: BaseTableViewController,
                            BaseViewControllerProtocol,
                            SignInViewControllerProtocol,
                            AuthStoryboardLodable {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    var onBack: (() -> Void)?
    var onSignIn: (() -> Void)?
    var onSignUp: (() -> Void)?
    
    var viewModel: SignInViewModel!
    private let validator = Validator()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupUI()
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func bindViewModel() {
        viewModel = SignInViewModel()
    }
    
    func setupUI() { }
    
    func bindUI() {
        observeLoading()
        onButtonSignInClick()
        onSuccess()
    }
       
    private func observeLoading() {
        viewModel.loading
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe({ event in
                if (event.element == true) {
                    LoadingView.show()
                } else {
                    LoadingView.hide()
                }
            }).disposed(by: bag)
    }
    
    private func onButtonSignInClick() {
        btnSignIn.rx.tap
            .asDriver().drive(onNext: { [weak self] in
                print("clicked login")
                self?.signIn()
        }).disposed(by: bag)
    }
    
    private func onSuccess() {
        viewModel.success
            .asObservable()
            .distinctUntilChanged()
            .bind(onNext: { success in
                if success {
                    self.onSignIn?()
                } else {
                    print("invalid credentials")
                }
        }).disposed(by: bag)
    }
    
    private func signIn() {
        viewModel.signIn(
            email: tfEmail.text ?? "",
            password: tfPassword.text ?? ""
        )
    }
}

// MARK: ValidationDelegate Methods

extension SignInViewController: ValidationDelegate {
    // Private method
    private func setUpValidator() {
        validator.registerField(tfEmail, rules: [RequiredRule(), EmailRule(), MinLengthRule(length: 5)])
        validator.registerField(tfPassword, rules: [RequiredRule(), MinLengthRule(length: 5)])
    }

    // ValidationDelegate methods
    func validationSuccessful() {
        signIn()
    }

    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for (field, error) in errors {
            if let field = field as? UITextField {
                field.layer.borderColor = UIColor.red.cgColor
                field.layer.borderWidth = 1.0
            }
            error.errorLabel?.text = error.errorMessage // works if you added labels
            error.errorLabel?.isHidden = false
        }
    }
}

