//
//  MoviesViewController.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 31/07/2024.
//

import UIKit
import Combine

class MoviesViewController: UIViewController {
  // MARK: - Properties
  private var subscriptions: Set<AnyCancellable> = []

  // MARK: - Dependencies
  private var viewModel: MoviesViewModel
  init(viewModel: MoviesViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Privates
  private
  func bindViews() {
    viewModel.$movies.sink { movies in
      print(movies)
      DispatchQueue.main.async { [weak self] in
        self?.moviesCollectionView.reloadData()
      }
    }
    .store(in: &subscriptions)
  }

  // MARK: - CollectionView
  private lazy var moviesCollectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ in
        MoviesViewController.createCompositionalLayout()
      }
    )
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(
      MovieCell.self,
      forCellWithReuseIdentifier: MovieCell.identifier
    )
    collectionView.delegate = self
    collectionView.dataSource = self
    return collectionView
  }()

  // MARK: - CompositionalLayout
  private static func createCompositionalLayout() -> NSCollectionLayoutSection {
    let largeItem = NSCollectionLayoutItem(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(2/3),
        heightDimension: .fractionalHeight(1.0)
      )
    )
    let verticalItem = NSCollectionLayoutItem(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1/3),
        heightDimension: .fractionalHeight(1.0)
      )
    )

    let topGroup = NSCollectionLayoutGroup.horizontal(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(2/5)
      ),
      subitems: [largeItem, verticalItem]
    )
    topGroup.interItemSpacing = .fixed(10)

    let bottomGroup = NSCollectionLayoutGroup.horizontal(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(2.5/5)
      ),
      repeatingSubitem: verticalItem,
      count: 3
    )
    bottomGroup.interItemSpacing = .fixed(10)

    let entireLayoutGroup = NSCollectionLayoutGroup.vertical(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(1.0)
      ),
      subitems: [topGroup, bottomGroup]
    )
    entireLayoutGroup.interItemSpacing = .fixed(10)

    let section = NSCollectionLayoutSection(group: entireLayoutGroup)
    return section
  }
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(moviesCollectionView)
    NSLayoutConstraint.activate([
      moviesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      moviesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
      moviesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      moviesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
    ])
    Task {
      await viewModel.viewMovies()
      bindViews()
    }
  }
}

// MARK: - UICollectionViewDataSource
extension MoviesViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.movies.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard 
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: MovieCell.identifier,
                                                  for: indexPath
      ) as? MovieCell
    else {
      return UICollectionViewCell()
    }
    cell.configure(with: viewModel.movies[indexPath.item])
    return cell
  }
}

// MARK: - UICollectionViewDelegate
extension MoviesViewController: UICollectionViewDelegate {

}
