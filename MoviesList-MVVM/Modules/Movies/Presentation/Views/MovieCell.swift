//
//  MovieCell.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 31/07/2024.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let dateLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let genresScrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()

  private let genresStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 4
    stackView.alignment = .center
    stackView.distribution = .equalSpacing
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel, genresScrollView])
    stackView.axis = .vertical
    stackView.spacing = 8
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(imageView)
    contentView.addSubview(stackView)

    // Adding border to the contentView
    contentView.layer.borderWidth = 1
    contentView.layer.borderColor = UIColor.lightGray.cgColor
    contentView.layer.cornerRadius = 8
    contentView.layer.masksToBounds = true

    genresScrollView.addSubview(genresStackView)

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),

      stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

      genresScrollView.heightAnchor.constraint(equalToConstant: 30),

      genresStackView.topAnchor.constraint(equalTo: genresScrollView.topAnchor),
      genresStackView.leadingAnchor.constraint(equalTo: genresScrollView.leadingAnchor),
      genresStackView.trailingAnchor.constraint(equalTo: genresScrollView.trailingAnchor),
      genresStackView.bottomAnchor.constraint(equalTo: genresScrollView.bottomAnchor),
      genresStackView.heightAnchor.constraint(equalTo: genresScrollView.heightAnchor)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with movie: MovieItem) {
    imageView.kf.setImage(with: URL(string: movie.posterPath))
    titleLabel.text = movie.title
    dateLabel.text = movie.releaseDate.toString(format: .yearMonthDay)

    genresStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

    let genres = movie.genres
    genres.forEach { genre in
      let chip = GenreChip(text: genre)
      genresStackView.addArrangedSubview(chip)
    }
    genresScrollView.contentSize = genresStackView.bounds.size
  }
}
