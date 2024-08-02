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
  @Published var searchText = ""
  @Published var isSearchActive = false
  private let debounceInterval = 0.3
  private var subscriptions: Set<AnyCancellable> = []

  // MARK: - Dependencies
  private var useCase: MoviesUseCase
  private var router: MoviesRouterProtocol

  init(
    useCase: MoviesUseCase,
    router: MoviesRouterProtocol
  ) {
    self.useCase = useCase
    self.router = router
    if isSearchActive {
      bindSearch()
    }
  }

  // MARK: - Privates
  private 
  func performSearch(with text: String) {
      Task {
          await self.searchMovies(with: text)
      }
  }

  private
  func bindSearch() {
      $searchText
          .debounce(
            for: .seconds(debounceInterval),
            scheduler: DispatchQueue.main
          )
          .removeDuplicates()
          .sink { [weak self] text in
              self?.performSearch(with: text)
          }
          .store(in: &subscriptions)
  }
}

extension MoviesViewModel {
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
    router.routeToDetails()
  }

  func searchMovies(with searchText: String) async {
    do {
      let moviesItems = try await useCase.search(with: searchText)
      if !moviesItems.movies.isEmpty {
        movies = moviesItems.movies
      }
    } catch {
      print(error) // WILL BE HANDLED
    }
  }
}
