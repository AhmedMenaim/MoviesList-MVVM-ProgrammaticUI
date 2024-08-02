//
//  Data+Extensions.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 31/07/2024.
//

import Foundation

extension Data {
  mutating func append(_ string: String) {
    if let data = string.data(using: .utf8) {
      append(data)
      print("data======>>>", data)
    }
  }
}
