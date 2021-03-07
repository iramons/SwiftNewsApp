//
//  Helper.swift
//  Swift-NewsApp
//
//  Created by Mac on 06/03/21.
//

import Foundation
import SystemConfiguration.CaptiveNetwork

class Helper {
    
    static var app: Helper = {
        return Helper()
    }()
    
    func isUserLoggedIn() -> Bool {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: Constants.Preferences.isUserLoggedIn)
        return isUserLoggedIn
    }
    
    func setUserLoggedIn(bool: Bool) {
        UserDefaults.standard.set(bool, forKey: Constants.Preferences.isUserLoggedIn)
    }
    
//    func setTokens(result: TokenResultResponse) {
//        setAccessToken(s: result.accessToken ?? "")
//        setRefreshToken(s: result.refreshToken ?? "")
//    }

    func setAccessToken(s: String) {
        UserDefaults.standard.set(s, forKey: Constants.Preferences.accessToken)
    }
    
    func getAccessToken() -> String {
        return UserDefaults.standard.string(forKey: Constants.Preferences.accessToken) ?? ""
    }

}
