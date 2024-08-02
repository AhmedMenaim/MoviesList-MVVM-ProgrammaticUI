//
//  UICollectionViewCell+Identifier.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 31/07/2024.
//

import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        String(describing: Self.self)
    }
}
