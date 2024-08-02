//
//  Print+Extensions.swift
//  MoviesList-MVVM
//
//  Created by Menaim on 31/07/2024.
//

import Foundation

/// Shadowing , To avoid having print statements on production (Only runs in debugging mode)
public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        Swift.print(items, separator: separator, terminator: terminator)
    #endif
}
