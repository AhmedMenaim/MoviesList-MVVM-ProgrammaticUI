//
//  MoviesAPIRequest.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation

enum MoviesAPIRequest: APIRequestConfiguration {
  case getMovies

  var method: HTTPMethod {
    switch self {
      case .getMovies:
        return .GET
    }
  }

  var path: String {
    switch self {
      case .getMovies:
        return "https://api.themoviedb.org/3/trending/movie/week?api_key=697d439ac993538da4e3e60b54e762cd"
    }
  }

  var parameters: Parameters? {
    nil
  }

  var headers: HTTPHeaders? {
    nil
  }

  var queryParams: [String : Any]? {
    nil
  }

  var files: [UploadMediaFile]? {
    nil
  }
}
