//
//  ViewController.swift
//  NewsApp
//
//  Created by Rawan Elsayed on 01/11/2024.
//

import UIKit

class ViewController: UIViewController , UISearchBarDelegate{
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var newsCollectionView: UICollectionView!
    let newsCell = "NewsCell"
    
    private var homeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchNewsData()
        
        searchBar.delegate = self
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        newsCollectionView.reloadData()
        fetchNewsData()
    }
    
    @objc func dateChanged() {
        fetchNewsData()
    }
    
    func setupCollectionView(){
        let nibCell = UINib(nibName: newsCell, bundle: nil)
        newsCollectionView.register(nibCell, forCellWithReuseIdentifier: newsCell)
        newsCollectionView.reloadData()
    }

    func fetchNewsData() {
        let selectedDate = datePicker.date
        let searchTerm = searchBar.text ?? ""
        homeViewModel.fetchNews(fromDate: selectedDate, query: searchTerm ) { [weak self] in
            self?.newsCollectionView.reloadData()
        }
    }
    
    @IBAction func goToFav(_ sender: UIButton) {
        if let favoriteVC = storyboard?.instantiateViewController(withIdentifier: "FavoriteViewController") as? FavoriteViewController {
            
            favoriteVC.modalPresentationStyle = .fullScreen
            present(favoriteVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fetchNewsData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.articlesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newsCell, for: indexPath) as! NewsCell
        
        let article = homeViewModel.article(at: indexPath.row)
        cell.newsTitle.text = article?.title
        cell.newsDescription.text = article?.description
        
        if let imageUrl = article?.urlToImage, let url = URL(string: imageUrl) {
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
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            // Pass any necessary data to the destination view controller here
            let selectedArticle = homeViewModel.article(at: indexPath.row)
            detailVC.article = selectedArticle

            detailVC.modalPresentationStyle = .fullScreen
            present(detailVC, animated: true, completion: nil)
        }
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


