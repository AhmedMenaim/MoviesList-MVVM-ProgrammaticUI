//
//  Date+Extensions.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation

extension Date {
  func toString(format: DateFormat = .yearMonthDay) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format.rawValue
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    return dateFormatter.string(from: self)
  }
}

enum DateFormat: String {
  case yearMonthDay = "yyyy-MM-dd"
  case monthDayYear = "MM-dd-yyyy"
  case dayMonthYear = "dd-MM-yyyy"
  // Add more formats as needed
}
