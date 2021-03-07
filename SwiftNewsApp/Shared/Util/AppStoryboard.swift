//
//  AppStoryboard.swift
//  Swift-NewsApp
//
//  Created by Mac on 06/03/21.
//

import Foundation
import UIKit

enum AppStoryboard : String {
    
    case main = "Feed"
    case auth = "Auth"
    case launch = "LaunchScreen"
    
    var instance : UIStoryboard {
      return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
    
    func initialViewController() -> UIViewController? {
        instance.instantiateInitialViewController()
    }
}

// USAGE :
//let storyboard = AppStoryboard.main.instance
