//
//  UIViewControllerExtensions.swift
//  Swift-NewsApp
//
//  Created by Mac on 06/03/21.
//

import Foundation
import UIKit
import RxSwift

extension UIViewController {
    
    class var storyboardID: String {
      return "\(self)"
    }
    
    static func instantiateFromAppStoryboard(appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    open func pushVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }

    open func popVC() {
        _ = navigationController?.popViewController(animated: true)
    }

    open func popToRootVC() {
        _ = navigationController?.popToRootViewController(animated: true)
    }

    open func presentVC(_ vc: UIViewController) {
        present(vc, animated: true, completion: nil)
    }
    
    //MARK: - Global Alert
    func alert(title: String = "Ops",
                   message: String,
                   alertStyle: UIAlertController.Style = .alert,
                   actionTitles: [String] = ["Entendi"],
                   actionStyles: [UIAlertAction.Style] = [.default],
                   actions: [((UIAlertAction) -> Void)] = [{_ in print("Entendi button clicked!")}])
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        
        for(index, indexTitle) in actionTitles.enumerated() {
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        
        self.present(alertController, animated: true)
    }
    
    //MARK: Global Toast
    func toast(message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
    
    struct AlertAction {
        var title: String?
        var style: UIAlertAction.Style
        
        static func action(title: String?, style: UIAlertAction.Style = .default) -> AlertAction {
            return AlertAction(title: title, style: style)
        }
        
    }
    
    static func present(
        in viewController: UIViewController,
        title: String?,
        message: String?,
        style: UIAlertController.Style,
        actions: [AlertAction]
    ) -> Observable<String> {
        return Observable.create { observer in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
            
            actions.forEach { action in
                let action = UIAlertAction(title: action.title, style: action.style) { _ in
                    if let text = action.title {
                    observer.onNext(text)
                    }
                    observer.onCompleted()
                }
                alertController.addAction(action)
            }
            
            viewController.present(alertController, animated: true, completion: nil)
            return Disposables.create { alertController.dismiss(animated: true, completion: nil)}
        }
    }
    
}


