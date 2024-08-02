//
//  MoviesRouter.swift
//  Movies-MVVM
//
//  Created by Menaim on 03/08/2024.
//

import UIKit

class MoviesRouter {
  // MARK: - Property
  weak var viewController: UIViewController?
}

// MARK: - MoviesRouterProtocol
extension MoviesRouter: MoviesRouterProtocol {
  func routeToDetails() {
    self.viewController?.navigationController?.pushViewController(
      MovieDetailsModuleFactory.makeModule(),
      animated: true
    )
  }
}
