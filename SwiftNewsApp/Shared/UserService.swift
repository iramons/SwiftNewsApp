//
//  UserService.swift
//  SwiftNewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation
import SwiftKeychainWrapper
import SwiftyJSON

final class UserService {
    static let shared: UserService = {
        let instance = UserService()
        // Setup code
        return instance
    }()

    init() {
        user = fetchUser()
    }

    private var user: User?

    func isAuthenticated() -> Bool {
        if loadToken() != nil {
            return true
        } else {
            return false
        }
    }

    func save(token: String) {
        KeychainWrapper.standard.set(token, forKey: "token")
    }

    func loadToken() -> String? {
        return KeychainWrapper.standard.string(forKey: "token")
    }

    func fetchUser() -> User? {
        var user: User?
        if let usr = UserDefaults.standard.value(forKey: "user") {
            let usrDictionary = usr as! [String: Any]
            let json = JSON(parseJSON: usrDictionary.json)
            user = User(fromJson: json)
        }
        return user
    }

    func saveUser(user: User) {
        UserDefaults.standard.set(user.toDictionary(), forKey: "user")
        self.user = user
    }

    func logout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "user")
        KeychainWrapper.standard.removeObject(forKey: "token")
        defaults.synchronize()
        user = nil
    }
}
