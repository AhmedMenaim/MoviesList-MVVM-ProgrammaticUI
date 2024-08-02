//
//  MovieCell.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 31/07/2024.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {

  private let posterImageView: UIImageView = {
    let posterImageView = UIImageView()
    posterImageView.contentMode = .scaleToFill
    posterImageView.clipsToBounds = true
    posterImageView.translatesAutoresizingMaskIntoConstraints = false
    return posterImageView
  }()

  private let titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.textAlignment = .center
    titleLabel.numberOfLines = 0
    titleLabel.lineBreakMode = .byWordWrapping
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    return titleLabel
  }()

  private let dateLabel: UILabel = {
    let dateLabel = UILabel()
    dateLabel.textAlignment = .center
    dateLabel.numberOfLines = 0
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    return dateLabel
  }()

  private let genresScrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()

  private let genresStackView: UIStackView = {
    let genresStackView = UIStackView()
    genresStackView.axis = .horizontal
    genresStackView.spacing = 4
    genresStackView.alignment = .center
    genresStackView.distribution = .equalSpacing
    genresStackView.translatesAutoresizingMaskIntoConstraints = false
    return genresStackView
  }()

  private lazy var containerStackView: UIStackView = {
    let containerStackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel, genresScrollView])
    containerStackView.axis = .vertical
    containerStackView.spacing = 8
    containerStackView.alignment = .fill
    containerStackView.distribution = .fill
    containerStackView.translatesAutoresizingMaskIntoConstraints = false
    return containerStackView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(posterImageView)
    contentView.addSubview(containerStackView)

    // Adding border to the contentView
    contentView.layer.borderWidth = 1
    contentView.layer.borderColor = UIColor.lightGray.cgColor
    contentView.layer.cornerRadius = 8
    contentView.layer.masksToBounds = true

    genresScrollView.addSubview(genresStackView)

    NSLayoutConstraint.activate([
      posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      posterImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),

      containerStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 8),
      containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

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
    posterImageView.kf.setImage(with: URL(string: movie.posterPath))
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
