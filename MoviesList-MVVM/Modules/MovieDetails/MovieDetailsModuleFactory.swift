//
//  MovieDetailsModuleFactory.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 03/08/2024.
//

import Foundation

class MovieDetailsModuleFactory {
  static func makeModule() -> MovieDetailsViewController {
    let useCase = MovieDetailsUseCase(
      sharedRepository: MovieSharedRepository.shared
    )
    let viewModel = MovieDetailsViewModel(useCase: useCase)
    let viewController = MovieDetailsViewController(viewModel: viewModel)
    return viewController
  }
}
