//
//  GenreLookupAPIClient.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation

protocol GenreAPIClientProtocol {
  func getGenre() async throws -> GenreNetworkResponse?
}

class GenreAPIClient {
  private var client: BaseAPIClientProtocol
  init(client: BaseAPIClientProtocol) {
    self.client = client
  }
}

// MARK: - GenreAPIClientProtocol
extension GenreAPIClient: GenreAPIClientProtocol {
  func getGenre() async throws -> GenreNetworkResponse? {
    let request = GenreAPIRequest.getGenre
    var Genre: GenreNetworkResponse?
    Genre = try await client.perform(request)
    return Genre
  }
}

