//
//  K+Storyboard.swift
//  SwiftNewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation
import UIKit

enum KStoryboard: String {
    case Feed
    case Auth
}

protocol StoryboardLodable: AnyObject {
    @nonobjc static var storyboardName: String { get }
}

protocol FeedStoryboardLodable: StoryboardLodable {}

protocol AuthStoryboardLodable: StoryboardLodable {}

extension FeedStoryboardLodable where Self: UIViewController {
    @nonobjc static var storyboardName: String {
        return KStoryboard.Feed.rawValue
    }
}

extension AuthStoryboardLodable where Self: UIViewController {
    @nonobjc static var storyboardName: String {
        return KStoryboard.Auth.rawValue
    }
}
