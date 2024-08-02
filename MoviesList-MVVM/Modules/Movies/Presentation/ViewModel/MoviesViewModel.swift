//
//  MoviesViewModel.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation
import Combine

@MainActor
final class MoviesViewModel: ObservableObject {
  @Published var movies: [MovieItem] = []

// MARK: - Dependencies
  private var useCase: MoviesUseCase
  init(useCase: MoviesUseCase) {
    self.useCase = useCase
  }

  func viewMovies() async {
    do {
      let moviesItems = try await useCase.fetchMovies()
      movies = moviesItems.movies
    } catch {
      print(error) // WILL BE HANDLED
    }
  }

  func didSelectItem(at indexPath: IndexPath) {
    useCase.selectMovie(at: indexPath.item)
  }
}
