//
//  GenreRepositoryProtocol.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation

protocol GenreRepositoryProtocol: GenreRepositoryGettable { }

protocol GenreRepositoryGettable {
  func getGenre() async throws -> [Int?: String?]?
}
