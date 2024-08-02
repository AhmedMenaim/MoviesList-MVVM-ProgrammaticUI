//
//  UploadMediaFile.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 31/07/2024.
//

import Foundation

struct UploadMediaFile {
  let key: String
  let filename: String
  let data: Data
  let mimeType: String
  init(data: Data, forKey key: String) {
    self.key = key
    self.mimeType = "image/jpeg"
    self.filename = "imagefile.jpg"
    self.data = data
  }
}
