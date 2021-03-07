//
//  Switcher.swift
//  Swift-NewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation
import UIKit

public class Switcher {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let navController = UINavigationController()
    let isUserLoggedIn = UserDefaults.standard.bool(forKey: Constants.Preferences.isUserLoggedIn)
    
//    func updateRootVC() {
//        if (isUserLoggedIn) {
//            let coordinator = FeedCoordinator(container: <#Container#>, navigationController: navController)
//            coordinator.start()
//        } else {
//            let coordinator = AuthCoordinator(container: <#Container#>, navigationController: navController)
//            coordinator.start()
//            appDelegate?.window?.rootViewController = navController
//            appDelegate?.window?.makeKeyAndVisible()
//        }
//    }
    
}
