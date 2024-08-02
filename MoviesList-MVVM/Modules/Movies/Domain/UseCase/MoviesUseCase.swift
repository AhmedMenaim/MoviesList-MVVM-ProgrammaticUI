//
//  MoviesUseCase.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation

final class MoviesUseCase {
  // MARK: - Private Vars
  private var movies: [MovieItem] = []

  // MARK: - Dependencies
  private var moviesRepository: MoviesRepositoryProtocol
  private var genresRepository: GenreRepositoryProtocol
  private var sharedRepository: MovieSharedRepositoryProtocol

  init(
    moviesRepository: MoviesRepositoryProtocol,
    genresRepository: GenreRepositoryProtocol,
    sharedRepository: MovieSharedRepositoryProtocol
  ) {
    self.moviesRepository = moviesRepository
    self.genresRepository = genresRepository
    self.sharedRepository = sharedRepository
  }


  // MARK: - Privates
  private func convert(_ repositoryItem: [MovieRepositoryModel]?) async -> [MovieItem] {
    var genres: [Int?: String?]?
    do {
      let genresResult = try await fetchGenres()
      genres = genresResult
    } catch {
      print(error)
    }
    guard
      let movies = repositoryItem, 
      let genres
    else {
      return []
    }
    return movies.compactMap({ movie in
      MovieItem(
        posterPath: movie.posterPath ?? "",
        title: movie.title ?? "",
        releaseDate: movie.releaseDate ?? Date(),
        genres: fetchStringGenres(genres, movie.genreIDs),
        id: movie.id ?? 0,
        voteAverage: movie.voteAverage ?? 0.0,
        voteCount: movie.voteCount ?? 0,
        overview: movie.overview ?? ""
      )
    })
  }

  private
  func convert(_ repositoryItem: MoviesRepositoryModel?) async -> MoviesItems {
    await MoviesItems(
      page: repositoryItem?.page ?? 0,
      movies: convert(repositoryItem?.movies),
      totalPages: repositoryItem?.totalPages ?? 0
    )
  }

  private func convert(_ movie: MovieItem) -> MovieSharedItem {
    MovieSharedItem(
      posterPath: movie.posterPath,
      title: movie.title,
      releaseDate: movie.releaseDate,
      genres: movie.genres,
      id: movie.id,
      voteAverage: movie.voteAverage,
      voteCount: movie.voteCount,
      overview: movie.overview
    )
  }

  private
  func fetchStringGenres(_ genreDictionary: [Int?: String?], _ usedIDs: [Int]?) -> [String] {
    guard let usedIDs else { return [] }
    return usedIDs.compactMap { genreDictionary[$0] ?? "Default" }
  }

  private
  func fetchGenres() async throws -> [Int?: String?] {
    guard let genres = try await genresRepository.getGenre() else {
      return [0:""]
    }
    return genres
  }
}

// MARK: - MoviesUseCaseProtocol
extension MoviesUseCase: MoviesUseCaseProtocol {
  func fetchMovies() async throws -> MoviesItems {
    guard let moviesItem = try await moviesRepository.getMovies() else {
      return MoviesItems()
    }
    let returnedMovies = await convert(moviesItem)
    movies = returnedMovies.movies
    return returnedMovies
  }

  func search(with searchText: String) async throws -> MoviesItems {
    guard let moviesItem = try await moviesRepository.getSearchedMovies(with: searchText) else {
      return MoviesItems()
    }
    let returnedMovies = await convert(moviesItem)
    if !movies.isEmpty {
      movies = returnedMovies.movies
    }
    return returnedMovies
  }

  func selectMovie(at row: Int) {
    guard !movies.isEmpty
    else { return }
    sharedRepository.save(
      movie: convert(movies[row])
    )
  }
}
