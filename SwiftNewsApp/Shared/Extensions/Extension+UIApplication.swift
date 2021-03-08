//
//  Extension+UIApplication.swift
//  SwiftNewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation
import UIKit

extension UIApplication {
    
    class func topVC(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topVC(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topVC(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topVC(base: presented)
        }
        return base
    }
}
