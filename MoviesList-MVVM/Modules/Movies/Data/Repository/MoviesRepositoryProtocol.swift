//
//  MoviesRepositoryProtocol.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation

protocol MoviesRepositoryProtocol: MoviesRepositoryGettable { }

protocol MoviesRepositoryGettable {
  func getMovies() async throws -> MoviesRepositoryModel?
}
