//
//  MovieDetailsUseCase.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation

final class MovieDetailsUseCase {
  // MARK: - Dependencies
  private var sharedRepository: MovieSharedRepositoryProtocol

  init(sharedRepository: MovieSharedRepositoryProtocol) {
    self.sharedRepository = sharedRepository
  }

  // MARK: - Privates
  private func convert(_ model: MovieSharedItem)
    -> MovieDetailsItem
  {
    MovieDetailsItem(
      posterPath: model.posterPath,
      title: model.title,
      releaseDate: model.releaseDate,
      genres: model.genres,
      id: model.id,
      voteAverage: model.voteAverage,
      voteCount: model.voteCount,
      overview: model.overview
      )
  }
}

// MARK: - MovieDetailsUseCaseProtocol
extension MovieDetailsUseCase: MovieDetailsUseCaseProtocol {
  func retrieveMovieDetails() async throws -> MovieDetailsItem? {
    guard
      let movieDetails = sharedRepository.get()
    else { return nil }
    return convert(movieDetails)
  }
}

