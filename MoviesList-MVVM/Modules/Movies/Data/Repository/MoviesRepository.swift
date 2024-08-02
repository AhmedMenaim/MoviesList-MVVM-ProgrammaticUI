//
//  MoviesRepository.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation

final class MoviesRepository {
  // MARK: - Vars
  private var client: MoviesAPIClientProtocol

  init(client: MoviesAPIClientProtocol) {
    self.client = client
  }

  // MARK: - Privates
  private 
  func convert(_ response: [MovieNetworkResponse]?) -> [MovieRepositoryModel]?
  {
    guard
      let movies = response
    else {
      return nil
    }
    return movies.map { movie in
      MovieRepositoryModel(
        posterPath: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "").jpg",
        title: movie.title,
        releaseDate: movie.releaseDate?.toDate(),
        genreIDs: movie.genreIDS,
        id: movie.id,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
        overview: movie.overview
      )
    }
  }

  private 
  func convert(_ response: MoviesNetworkResponse?) -> MoviesRepositoryModel {
    MoviesRepositoryModel(
      page: response?.page,
      movies: convert(response?.movies),
      totalPages: response?.totalPages
    )
  }
}

extension  MoviesRepository: MoviesRepositoryProtocol {
  func getMovies() async throws -> MoviesRepositoryModel? {
    var movies: MoviesRepositoryModel?
    do {
      movies = convert(try await client.getMovies())
    } catch {
      guard let error = error as? SessionDataTaskError else {
        throw RepositoryError.unowned
      }
      throw RepositoryError(error: error)
    }
    return movies
  }

  func getSearchedMovies(with searchedText: String) async throws -> MoviesRepositoryModel? {
    var movies: MoviesRepositoryModel?
    do {
      movies = convert(try await client.getSearchedMovies(with: searchedText))
    } catch {
      guard let error = error as? SessionDataTaskError else {
        throw RepositoryError.unowned
      }
      throw RepositoryError(error: error)
    }
    return movies
  }

}
