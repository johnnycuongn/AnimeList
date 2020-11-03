//
//  Helpers.swift
//  AnimeList
//
//  Created by Johnny on 3/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation

enum EmptyReturnType: String {
    case dash = "-"
    case none = ""
}
/// Validate for optional Label?
/// Usage:
///
///     animeRankTitle.text = validateLabel(animeInfo.rank, return: .dash)
///
/// - Parameter label: Label to validate
/// - Parameter return: String to return when `Label` is empty
///
/// - Returns: Valid string return
func validateLabel<T>(_ label: T?, return stringType: EmptyReturnType = .dash) -> String {
    if label == nil {
        return stringType.rawValue
    }
    
    return String(describing: label!)
}
