//
//  Extension+Swinject.swift
//  Swift-NewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation
import Swinject
import SwinjectStoryboard

extension Container {
    /**
     Retrieves UIViewController of the specified type. The UIViewController must conform to StoryboardLodable

     - Parameter serviceType: UIViewController type
     - Returns: UIViewController of specified type
     */
    func resolveViewController<ViewController: StoryboardLodable>(_ serviceType: ViewController.Type) -> ViewController {
        let sb = SwinjectStoryboard.create(name: serviceType.storyboardName, bundle: nil, container: self)
        let name = "\(serviceType)"//.replacingOccurrences(of: "ViewController", with: "")
        return sb.instantiateViewController(withIdentifier: name) as! ViewController
    }
}
