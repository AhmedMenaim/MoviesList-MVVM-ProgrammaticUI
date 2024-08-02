//
//  MoviesUseCaseProtocol.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation

protocol MoviesUseCaseProtocol {
  func fetchMovies() async throws -> MoviesItems
  func search(with searchText: String) async throws -> MoviesItems
  func selectMovie(at row: Int)
}

struct MoviesItems {
  let page: Int
  let movies: [MovieItem]
  let totalPages: Int

  init(
    page: Int = 0,
    movies: [MovieItem] = [],
    totalPages: Int = 0
  ) {
    self.page = page
    self.movies = movies
    self.totalPages = totalPages
  }
}

struct MovieItem: Identifiable {
  let posterPath: String
  let title: String
  let releaseDate: Date
  let genres: [String]
  let id: Int
  let voteAverage: Double
  let voteCount: Int
  let overview: String
}
