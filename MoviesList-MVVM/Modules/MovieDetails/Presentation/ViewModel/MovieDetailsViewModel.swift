//
//  MovieDetailsViewModel.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation
import Combine

final class MovieDetailsViewModel {
  // MARK: - Dependencies
  private var useCase: MovieDetailsUseCaseProtocol
  init(useCase: MovieDetailsUseCaseProtocol) {
    self.useCase = useCase
  }

  // MARK: - Properties
  @Published var movieDetails = MovieDetailsItem()
}

// MARK: - MovieDetailsViewModelProtocol
extension MovieDetailsViewModel {
  func movieDetailsViewItem() async {
    do {
      guard let details = try await useCase.retrieveMovieDetails() else { return }
      movieDetails = details
    } catch {
      print(error)
    }
  }
}
