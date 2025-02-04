//
//  MoviesModuleFactory.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation

class MoviesModuleFactory {
  @MainActor 
  static func makeModule() -> MoviesViewController {
    let baseAPIClient = BaseAPIClient()
    let moviesClient = MoviesAPIClient(client: baseAPIClient)
    let genresClient = GenreAPIClient(client: baseAPIClient)
    let moviesRepository = MoviesRepository(client: moviesClient)
    let genresRepository = GenreRepository(client: genresClient)
    let useCase = MoviesUseCase(
      moviesRepository: moviesRepository,
      genresRepository: genresRepository,
      sharedRepository: MovieSharedRepository.shared
    )
    let router = MoviesRouter()
    let viewModel = MoviesViewModel(
      useCase: useCase,
      router: router
    )
    let viewController = MoviesViewController(viewModel: viewModel)
    router.viewController = viewController
    return viewController
  }
}
