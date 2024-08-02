//
//  MovieDetailsUseCaseProtocol.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation

protocol MovieDetailsUseCaseProtocol {
  func retrieveMovieDetails() async throws -> MovieDetailsItem?
}

struct MovieDetailsItem {
  let posterPath: String
  let title: String
  let releaseDate: Date
  let genres: [String]
  let id: Int
  let voteAverage: Double
  let voteCount: Int
  let overview: String
  init(
    posterPath: String = "",
    title: String = "",
    releaseDate: Date = Date(),
    genres: [String] = [],
    id: Int = 0,
    voteAverage: Double = 0,
    voteCount: Int = 0,
    overview: String = ""
  ) {
    self.posterPath = posterPath
    self.title = title
    self.releaseDate = releaseDate
    self.genres = genres
    self.id = id
    self.voteAverage = voteAverage
    self.voteCount = voteCount
    self.overview = overview
  }
}
