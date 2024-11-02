//
//  FavoriteViewController.swift
//  NewsApp
//
//  Created by Rawan Elsayed on 02/11/2024.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    let newsCell = "NewsCell"
    private let favoritesViewModel = FavoritesViewModel()
    var favoriteArticles: [FavoriteArticles] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchFavoriteArticles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoriteArticles()
    }

    func setupCollectionView(){
        let nibCell = UINib(nibName: newsCell, bundle: nil)
        favoriteCollectionView.register(nibCell, forCellWithReuseIdentifier: newsCell)
        favoriteCollectionView.reloadData()
    }
    
    private func fetchFavoriteArticles() {
        favoriteArticles = favoritesViewModel.fetchFavoriteArticles()
        favoriteCollectionView.reloadData()
    }
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newsCell, for: indexPath) as! NewsCell
        
        let article = favoriteArticles[indexPath.row]
        cell.newsTitle.text = article.title
        cell.newsDescription.text = article.desc
        
        if let imageUrl = article.image, let url = URL(string: imageUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.newsImg.image = UIImage(data: data)
                    }
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cell is tapped")
//        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
//            let selectedArticle = favoriteArticles[indexPath.row]
//            detailVC.article = selectedArticle
//
//            detailVC.modalPresentationStyle = .fullScreen
//            present(detailVC, animated: true, completion: nil)
//        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20
        let availableWidth = (collectionView.frame.width / 2) - padding
        let widthPerItem = availableWidth
        let heightPerItem: CGFloat = (collectionView.frame.height / 2) - padding
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 10
        return UIEdgeInsets(top: inset, left: inset, bottom: 20, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}



