//
//  LaunchInstructor.swift
//  Swift-NewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation

enum LaunchInstructor {
    case feed
    case auth

    // MARK: - Public methods

    static func configure(isAutorized: Bool = false) -> LaunchInstructor {
        let isAutorized = isAutorized

        switch isAutorized {
        case false: return .auth
        case true: return .feed
        }
    }
}
