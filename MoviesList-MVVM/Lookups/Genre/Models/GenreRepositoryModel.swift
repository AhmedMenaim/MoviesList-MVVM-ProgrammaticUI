//
//  GenreRepositoryModel.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import Foundation

struct GenreRepositoryModel {
  var genreDictionary: [Int?: String?]

  init(genreDictionary: [Int? : String?] = [0:""]) {
    self.genreDictionary = genreDictionary
  }
}
