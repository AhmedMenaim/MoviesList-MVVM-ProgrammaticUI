//
//  MovieSharedRepository.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation

class MovieSharedRepository {

  // MARK: - Properties
  private var movie: MovieSharedItem?

  // MARK: - Singleton

  private init() { }

  static var shared = MovieSharedRepository()
}

// MARK: - MovieSharedRepositoryProtocol
extension MovieSharedRepository: MovieSharedRepositoryProtocol {
  func get() -> MovieSharedItem? {
    MovieSharedRepository.shared.movie
  }

  func save(movie: MovieSharedItem) {
    MovieSharedRepository.shared.movie = movie
  }

  func clear() {
    movie = nil
  }
}
