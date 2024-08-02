//
//  GenreLookupAPIRequest.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation

enum GenreAPIRequest: APIRequestConfiguration {
  case getGenre

  var method: HTTPMethod {
    switch self {
      case .getGenre:
        return .GET
    }
  }

  var path: String {
    switch self {
      case .getGenre:
        return "https://api.themoviedb.org/3/genre/movie/list?api_key=697d439ac993538da4e3e60b54e762cd"
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
