//
//  MovieSharedRepositoryProtocol.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation

protocol MovieSharedRepositoryProtocol: MovieSharedRepositoryGettable,
  MovieSharedRepositorySavable,
  MovieSharedRepositoryClearable { }

protocol MovieSharedRepositoryGettable {
  func get() -> MovieSharedItem?
}

protocol MovieSharedRepositorySavable {
  func save(movie: MovieSharedItem)
}

protocol MovieSharedRepositoryClearable {
  func clear()
}

// MARK: - MovieSharedItem
struct MovieSharedItem {
  let posterPath: String
  let title: String
  let releaseDate: Date
  let genres: [String]
  let id: Int
  let voteAverage: Double
  let voteCount: Int
  let overview: String
}
