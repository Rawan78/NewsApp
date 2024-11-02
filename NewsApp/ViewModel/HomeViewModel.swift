//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Rawan Elsayed on 02/11/2024.
//

import Foundation

class HomeViewModel {
    private var articles: [Article] = []
    
    var articlesCount: Int {
        return articles.count
    }
    
    func fetchNews(fromDate: Date? = nil, query: String = "", completion: @escaping () -> Void) {
        NetworkManager.shared.fetchNews(fromDate: fromDate, query: query) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                DispatchQueue.main.async {
                    completion()
                }
            case .failure(let error):
                print("Error fetching news: \(error)")
            }
        }
    }
    
    func article(at index: Int) -> Article? {
        guard index < articles.count else { return nil }
        return articles[index]
    }
}

