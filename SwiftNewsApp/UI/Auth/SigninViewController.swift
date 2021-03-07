//
//  SigninViewController.swift
//  Swift-NewsApp
//
//  Created by Mac on 07/03/21.
//

import RxCocoa
import RxSwift
//import SwiftValidator
import Swinject
import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    var onBack: (() -> Void)? { get set }
    var onLogin: (() -> Void)? { get set }
    var onSignUp: (() -> Void)? { get set }
}

class SigninViewController: BaseTableViewController,
                            BaseViewControllerProtocol,
                            LoginViewControllerProtocol,
                            AuthStoryboardLodable {
    
    var onBack: (() -> Void)?
    var onLogin: (() -> Void)?
    var onSignUp: (() -> Void)?
    
    var viewModel: SignInViewModel!
    
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
    
    func setupUI() {
        
    }
    
    func bindUI() {
        
    }
    
    @IBAction func actionSignUP(_: Any) {
        onSignUp?()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
