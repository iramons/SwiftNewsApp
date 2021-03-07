//
//  BaseViewController.swift
//  Swift-NewsApp
//
//  Created by Mac on 06/03/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


/// BaseViewControllerProtocol: Add this functions to your ViewController calling this protocol.
/// - Note: Config your View Controller in this sequence, first bindViewModel(), second setupUI() and third bindUI()
/// This sequence will grants your VC correct initialization
protocol BaseViewControllerProtocol {
    func bindViewModel()
    func setupUI()
    func bindUI()
}

public class BaseViewController: UIViewController,
                                 UITextFieldDelegate {

//    let network: NetworkManager = NetworkManager.sharedInstance
    var disconnectedView : UIView = UIView()
    
//    let baseData  =  BaseData.sharedInstance
//    let restClient = RestClient.sharedInstance
    var loading : UIView?
//    var spinnerVC : SpinnerVC?
    
    let bag = DisposeBag()
    
    func configureNavBar(
        title: String,
        buttonItem: UIBarButtonItem,
        buttonTitle: String = "",
        buttonImageName: String = ""
    ) {
        setTitle(s: title)
        setBarButtonItem(item: buttonItem,
                         title: buttonTitle,
                         imageName: buttonImageName)
    }
    
    func setTitle(s: String) {
        self.title = s
    }
    
    func setBarButtonItem(
        item: UIBarButtonItem,
        title: String? = nil,
        imageName: String? = nil,
        systemImageName: String? = nil
    ) {
        if #available(iOS 13.0, *) {
            if systemImageName != nil {
                item.image = UIImage.init(systemName: systemImageName ?? "")
            } else {
                item.image = UIImage.init(named: imageName ?? "")
            }
        }
    }

    @available(iOS 13.0, *)
    public func showSpinner(onView : UIView) {
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = onView.center
             
        DispatchQueue.main.async {
            onView.addSubview(ai)
        }
        loading = ai
    }
//
//    func addSpinnerView() {
//        print("-spinner add()")
//        if spinnerVC != nil && (spinnerVC?.isViewLoaded)! && (spinnerVC?.view.window != nil) {
//            return
//        } else {
//            spinnerVC = SpinnerVC()
//            spinnerVC?.modalPresentationStyle = .overFullScreen
//            self.view.viewController()?.present(spinnerVC!, animated: false, completion: nil)
//        }
//    }
//
//    func removeSpinnerView() {
//        print("-spinner remove()")
//        if spinnerVC != nil {
//            spinnerVC?.dismiss(animated: false, completion: nil)
//        }
//    }
//
    override public func viewDidLayoutSubviews() {
        self.loading?.center = self.view.center
    }
    
    public func removeSpinner() {
        DispatchQueue.main.async {
            self.loading?.removeFromSuperview()
            self.loading = nil
        }
    }
    
    public override func viewDidLoad() {
        observeNetworkConnection()
    }
    
    public override func viewDidAppear(_ animated: Bool) { }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func dismissKeyboard() {view.endEditing(true)}
    
    func observeNetworkConnection() {
//        NetworkManager.isReachable { _ in
//            self.removeDisconnectedView()
//        }
//        
//        NetworkManager.isUnreachable { _ in
//            self.addDisconnectedView()
//        }
//        
//        network.reachability.whenReachable = { _ in
//            self.removeDisconnectedView()
//        }
//        
//        network.reachability.whenUnreachable = { _ in
//            self.addDisconnectedView()
//        }
    }
    
    func addDisconnectedView() -> Void {
        DispatchQueue.main.async {
            self.disconnectedView = (Bundle.main.loadNibNamed("DisconnectedView", owner: self, options: nil))?[0] as! UIView
            self.disconnectedView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 88 )
            UIView.transition(with: self.view, duration: 1.0, options: [.transitionCrossDissolve], animations: {
                UIApplication.shared.keyWindow?.addSubview(self.disconnectedView)
                UIApplication.shared.keyWindow?.bringSubviewToFront(self.disconnectedView)
            }, completion: nil)
        }
    }
    
    func removeDisconnectedView() {
        UIView.transition(with: self.view, duration: 1.0, options: [.transitionCrossDissolve], animations: {
          self.disconnectedView.removeFromSuperview()
        }, completion: nil)
    }
    
}

