//
//  PersistenceProtocol.swift
//  NewsApp
//
//  Created by Valera Sysov on 11.03.22.
//

import Foundation

protocol PersistenceProtocol {
    func readFavorites() -> [Article]
    func saveFavorites(_ favorites:[Article])
}
