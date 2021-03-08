//
//  AppDelegate.swift
//  Swift-NewsApp
//
//  Created by Mac on 06/03/21.
//

import UIKit
import CoreData
import Swinject
import AlamofireNetworkActivityLogger

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    internal let container = Container()
    private var appCoordinator: AppCoordinator!
    var assembler: Assembler!
    let navController = BaseNavigationController()

    func application(_: UIApplication, willFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        assembler = Assembler([
            AuthAssembly(),
            FeedAssembly()
        ], container: container)

        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        let context = CoreDataHelper.shared.persistentContainer.viewContext // 1
        NetworkActivityLogger.shared.startLogging()
        
        window = UIWindow()

        let logged = Helper.app.isUserLoggedIn()
        print("logged == \(logged)")
        
        appCoordinator = AppCoordinator(window: window!, container: container, navigationController: navController, launchInstructor: LaunchInstructor.configure(isAutorized: UserService.shared.isAuthenticated()))

        appCoordinator.start()
        
        window?.makeKeyAndVisible()
        return true
    }

    
    func applicationDidEnterBackground(_ application: UIApplication) {
        CoreDataHelper.shared.saveContext()
    }

}

