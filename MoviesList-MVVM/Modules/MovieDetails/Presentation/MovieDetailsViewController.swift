//
//  MovieDetailsViewController.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 03/08/2024.
//

import UIKit
import Combine
import Kingfisher

class MovieDetailsViewController: UIViewController {
  // MARK: - Properties
  private var subscriptions: Set<AnyCancellable> = []

  // MARK: - Dependencies
  private var viewModel: MovieDetailsViewModel
  init(viewModel: MovieDetailsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI Components
  private let containerScrollView: UIScrollView = {
    let containerScrollView = UIScrollView()
    containerScrollView.translatesAutoresizingMaskIntoConstraints = false
    return containerScrollView
  }()

  private let contentView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

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
    titleLabel.numberOfLines = 3
    titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    return titleLabel
  }()

  private let dateLabel: UILabel = {
    let dateLabel = UILabel()
    dateLabel.textAlignment = .left
    dateLabel.numberOfLines = 0
    dateLabel.lineBreakMode = .byWordWrapping
    dateLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    return dateLabel
  }()

  private let genresScrollView: UIScrollView = {
    let genresScrollView = UIScrollView()
    genresScrollView.showsHorizontalScrollIndicator = false
    genresScrollView.translatesAutoresizingMaskIntoConstraints = false
    return genresScrollView
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

  private let descriptionLabel: UILabel = {
    let descriptionLabel = UILabel()
    descriptionLabel.textAlignment = .left
    descriptionLabel.numberOfLines = 0
    descriptionLabel.lineBreakMode = .byWordWrapping
    descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    return descriptionLabel
  }()

  private let ratingLabel: UILabel = {
    let ratingLabel = UILabel()
    ratingLabel.textAlignment = .center
    ratingLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    ratingLabel.textColor = .systemYellow
    ratingLabel.translatesAutoresizingMaskIntoConstraints = false
    return ratingLabel
  }()

  private let voteCountLabel: UILabel = {
    let voteCountLabel = UILabel()
    voteCountLabel.textAlignment = .center
    voteCountLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    voteCountLabel.translatesAutoresizingMaskIntoConstraints = false
    return voteCountLabel
  }()

  private let voteAverageLabel: UILabel = {
    let voteAverageLabel = UILabel()
    voteAverageLabel.textAlignment = .center
    voteAverageLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    voteAverageLabel.translatesAutoresizingMaskIntoConstraints = false
    return voteAverageLabel
  }()

  private lazy var ratingStackView: UIStackView = {
    let ratingStackView = UIStackView(arrangedSubviews: [voteCountLabel, voteAverageLabel])
    ratingStackView.axis = .horizontal
    ratingStackView.spacing = 16
    ratingStackView.alignment = .center
    ratingStackView.distribution = .equalSpacing
    ratingStackView.translatesAutoresizingMaskIntoConstraints = false
    return ratingStackView
  }()

  private lazy var containerStackView: UIStackView = {
    let containerStackView = UIStackView(
      arrangedSubviews: [
        titleLabel,
        dateLabel,
        genresScrollView,
        descriptionLabel,
        ratingLabel,
        ratingStackView
      ]
    )
    containerStackView.axis = .vertical
    containerStackView.spacing = 16
    containerStackView.alignment = .fill
    containerStackView.distribution = .fill
    containerStackView.translatesAutoresizingMaskIntoConstraints = false
    return containerStackView
  }()

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    Task {
     await viewModel.movieDetailsViewItem()
      bindViews()
    }
  }

  // MARK: - Privates
  private 
  func bindViews() {
    viewModel.$movieDetails.sink { details in
      DispatchQueue.main.async { [weak self] in
        self?.setupUI()
        self?.configure(with: details)
      }
    }
    .store(in: &subscriptions)
  }

  // MARK: - Setup UI
  private 
  func setupUI() {
    view.backgroundColor = .white

    view.addSubview(containerScrollView)
    containerScrollView.addSubview(contentView)
    contentView.addSubview(posterImageView)
    contentView.addSubview(containerStackView)
    genresScrollView.addSubview(genresStackView)

    NSLayoutConstraint.activate([
      containerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      containerScrollView.topAnchor.constraint(equalTo: view.topAnchor),
      containerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      containerScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      contentView.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor),
      contentView.topAnchor.constraint(equalTo: containerScrollView.topAnchor),
      contentView.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: containerScrollView.bottomAnchor),
      contentView.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor),

      posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      posterImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75),

      containerStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 16),
      containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

      genresScrollView.heightAnchor.constraint(equalToConstant: 30),

      genresStackView.topAnchor.constraint(equalTo: genresScrollView.topAnchor),
      genresStackView.leadingAnchor.constraint(equalTo: genresScrollView.leadingAnchor),
      genresStackView.trailingAnchor.constraint(equalTo: genresScrollView.trailingAnchor),
      genresStackView.bottomAnchor.constraint(equalTo: genresScrollView.bottomAnchor),
      genresStackView.heightAnchor.constraint(equalTo: genresScrollView.heightAnchor)
    ])
  }

  // MARK: - Configure

  private func configure(with movie: MovieDetailsItem) {
    posterImageView.kf.setImage(with: URL(string: movie.posterPath))
    titleLabel.text = movie.title
    dateLabel.text = "Release Date: \(movie.releaseDate.toString(format: .yearMonthDay))"
    descriptionLabel.text = movie.overview
    ratingLabel.text = "Rating: \(movie.voteAverage)"
    voteCountLabel.text = "Votes: \(movie.voteCount)"
    voteAverageLabel.text = "Average: \(movie.voteAverage)"

    // Clear previous genre chips
    genresStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

    // Add new genre chips
    let genres = movie.genres // Assume genres is an array of strings
    genres.forEach { genre in
      let chip = GenreChip(text: genre)
      genresStackView.addArrangedSubview(chip)
    }

    // Update the content size of the scroll view
    genresScrollView.contentSize = genresStackView.bounds.size
  }
}
