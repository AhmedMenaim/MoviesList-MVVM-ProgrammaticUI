//
//  GenreChip.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 02/08/2024.
//

import UIKit

class GenreChip: UIView {
  private let label: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    label.numberOfLines = 1
    return label
  }()

  init(text: String) {
    super.init(frame: .zero)
    label.text = text
    setupView()
  }

  private func setupView() {
    backgroundColor = UIColor.systemBlue
    layer.cornerRadius = 8
    layer.masksToBounds = true

    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
      label.topAnchor.constraint(equalTo: topAnchor, constant: 4),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
