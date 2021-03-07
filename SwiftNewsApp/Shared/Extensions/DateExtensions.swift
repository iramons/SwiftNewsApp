//
//  DateExtensions.swift
//  Swift-NewsApp
//
//  Created by Mac on 07/03/21.
//

import Foundation

extension Date {
    func string(withFormat format: String = "dd/MM/yy HH:mm") -> String {
          let dateFormatter = DateFormatter()
            dateFormatter.timeZone = .current
          dateFormatter.dateFormat = format
          let str = dateFormatter.string(from: self)
          return str
      }
}
