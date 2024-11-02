//
//  CoreDataService.swift
//  NewsApp
//
//  Created by Rawan Elsayed on 02/11/2024.
//


import CoreData
import UIKit

class CoreDataService {
    static let shared = CoreDataService()
    private init() {}

    // Save Favorite Article
    func saveFavoriteArticle(title: String, description: String, image: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        let favoriteArticle = FavoriteArticles(context: context)
        favoriteArticle.title = title
        favoriteArticle.desc = description
        favoriteArticle.image = image
        
        do {
            try context.save()
            print("Article saved to favorites")
        } catch {
            print("Failed to save article: \(error.localizedDescription)")
        }
    }

    // Fetch Favorite Articles
    func fetchFavoriteArticles() -> [FavoriteArticles] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<FavoriteArticles> = FavoriteArticles.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch articles: \(error.localizedDescription)")
            return []
        }
    }
}
