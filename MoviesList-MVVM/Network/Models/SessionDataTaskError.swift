//
//  SessionDataTaskError.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 31/07/2024.
//

import Foundation

enum SessionDataTaskError: Error {
  case failWithError(Error)
  case notValidURL
  case requestFailed
  case noData
  case notFound
  case notAuthorized
  case server
  case noInternetConnection
  case internalError(SessionDataTaskErrorResponse)
  case emptyErrorWithStatusCode(String)
}
