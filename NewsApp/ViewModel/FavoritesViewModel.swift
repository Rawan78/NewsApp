//
//  FavoritesViewModel.swift
//  NewsApp
//
//  Created by Rawan Elsayed on 02/11/2024.
//

import Foundation

class FavoritesViewModel {
    private let coreDataService = CoreDataService.shared

    // Save a favorite article
    func saveFavoriteArticle(title: String, description: String , image: String) {
        coreDataService.saveFavoriteArticle(title: title, description: description , image: image)
    }

    // Fetch favorite articles
    func fetchFavoriteArticles() -> [FavoriteArticles] {
        return coreDataService.fetchFavoriteArticles()
    }
}
