//
//  LoadingView.swift
//  SwiftNewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation
import SVProgressHUD

class LoadingView {
    
    static func show() {
        SVProgressHUD.setBackgroundColor( .white)
        SVProgressHUD.setForegroundColor( .systemBlue)
        SVProgressHUD.show()
    }
    
    static func hide() {
        SVProgressHUD.dismiss()
    }
    
}
