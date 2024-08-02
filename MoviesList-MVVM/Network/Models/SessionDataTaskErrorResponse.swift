//
//  SessionDataTaskErrorResponse.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 31/07/2024.
//

import Foundation

struct SessionDataTaskErrorResponse: Codable {
  let error: SessionDataTaskErrorModel?
}

struct SessionDataTaskErrorModel: Codable {
  let code: Int?
  let status: Int?
  let message: String?
}
