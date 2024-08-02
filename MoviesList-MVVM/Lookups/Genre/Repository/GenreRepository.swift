//
//  GenreRepository.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation

final class GenreRepository {
  // MARK: - Vars
  private var client: GenreAPIClientProtocol

  init(client: GenreAPIClientProtocol) {
    self.client = client
  }

  // MARK: - Privates
  private
  func convert(_ response: GenreNetworkResponse?) -> [Int?: String?]?
  {
    guard
      let genres = response?.genres
    else {
      return nil
    }
    let genresDict = Dictionary(
      uniqueKeysWithValues: genres.map {
        ($0.id, $0.name)
      }
    )
    return genresDict
  }
}

// MARK: - GenreRepositoryProtocol
extension  GenreRepository: GenreRepositoryProtocol {
  func getGenre() async throws -> [Int? : String?]? {
    var genresDictionary: [Int? : String?]?
    do {
      genresDictionary = convert(try await client.getGenre())
    } catch {
      guard let error = error as? SessionDataTaskError else {
        throw RepositoryError.unowned
      }
      throw RepositoryError(error: error)
    }
    return genresDictionary
  }
}
