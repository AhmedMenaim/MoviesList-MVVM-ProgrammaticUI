//
//  MoviesAPIClient.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation

protocol MoviesAPIClientProtocol {
  func getMovies() async throws -> MoviesNetworkResponse?
  func getSearchedMovies(with searchedText: String) async throws -> MoviesNetworkResponse?
}

class MoviesAPIClient {
  private var client: BaseAPIClientProtocol
  init(client: BaseAPIClientProtocol) {
    self.client = client
  }
}

// MARK: - MoviesAPIClientProtocol
extension MoviesAPIClient: MoviesAPIClientProtocol {
  func getMovies() async throws -> MoviesNetworkResponse? {
    let request = MoviesAPIRequest.getMovies
    var movies: MoviesNetworkResponse?
    movies = try await client.perform(request)
    return movies
  }

  func getSearchedMovies(with searchedText: String) async throws -> MoviesNetworkResponse? {
    let request = MoviesAPIRequest.getSearchedMovies(searchText: searchedText)
    var movies: MoviesNetworkResponse?
    movies = try await client.perform(request)
    return movies
  }
}
