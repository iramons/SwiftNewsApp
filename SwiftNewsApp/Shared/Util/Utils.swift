//
//  Utils.swift
//  SwiftNewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation
import UIKit

class Utils {
    
    static func checkError(error: ErrorResult) {
        if error.code == "INVALID_TOKEN" {
            UserService.shared.logout()
        } else {
            alertErrorResult(message: error.message ?? "Unexpected error")
        }
    }
    
    static func alertErrorResult(message: String) {
        let isShowingAlert = UIApplication.topVC()!.isAlertViewPresenting
        if !isShowingAlert {
            UIApplication.topVC()!.alert(message: message)
        }
    }
    
    
}
