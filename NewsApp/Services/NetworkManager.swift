//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Rawan Elsayed on 02/11/2024.
//

import Foundation

class NetworkManager {
    let apiKey = "55120073354e4575a79f17edb1d35828"
    let baseURL = "https://newsapi.org/v2/everything"
    
    static let shared = NetworkManager()
    
    func fetchNews(fromDate: Date? = nil, query: String = "tesla", completion: @escaping (Result<[Article], Error>) -> Void) {
        var urlString = "\(baseURL)?"
        
        // Use "tesla" if query is empty
        urlString += "q=\(query.isEmpty ? "tesla" : query)&"
        
        if let fromDate = fromDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let formattedDate = dateFormatter.string(from: fromDate)
            urlString += "from=\(formattedDate)&"
        }
        
        // Add sortBy before the API key
        urlString += "sortBy=publishedAt&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            do {
                let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(.success(newsResponse.articles ?? []))
                print(newsResponse.totalResults ?? 0)
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
        
        print("Request URL: \(urlString)")
    }
}

