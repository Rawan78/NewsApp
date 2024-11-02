//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Rawan Elsayed on 02/11/2024.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var newsImg: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var addToFavBtn: UIButton!
    var article: Article?
    private let favoritesViewModel = FavoritesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backView.layer.cornerRadius = 16
        newsImg.layer.cornerRadius = 16
        addToFavBtn.layer.cornerRadius = 20
        
        if let article = article {
            print("Title: \(article.title )")
            print("Description: \(article.description ?? "No Description")")
            
            newsTitle.text = article.title
            newsDescription.text = article.description
            if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            self.newsImg.image = UIImage(data: data)
                        }
                    }
                }
            }
           
        }

    }
    @IBAction func addToFavAction(_ sender: UIButton) {
        guard let article = article else { return }
        favoritesViewModel.saveFavoriteArticle(title: article.title, description: article.description ?? "" , image: article.urlToImage ?? "")
        print("added to fav")
        
        // Show success alert
        let alert = UIAlertController(title: "\(article.title)", message: "added to favorite successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
