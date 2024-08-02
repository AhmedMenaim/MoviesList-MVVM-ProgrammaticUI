//
//  MoviesAPIRequest.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation

enum MoviesAPIRequest: APIRequestConfiguration {
  case getMovies
  case getSearchedMovies(searchText: String)

  var method: HTTPMethod {
    switch self {
      case .getMovies:
        return .GET
      case .getSearchedMovies:
        return .GET
    }
  }

  var path: String {
    switch self {
        /// We can save the APIKey in keychain
        /// Also create a common BaseURL and paths for each one.
      case .getMovies:
        return "https://api.themoviedb.org/3/trending/movie/week?api_key=697d439ac993538da4e3e60b54e762cd"
      case.getSearchedMovies(let searchText):
        return "https://api.themoviedb.org/3/search/movie?query=\(searchText)&api_key=697d439ac993538da4e3e60b54e762cd"
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
