//
//  NewsCell.swift
//  NewsApp
//
//  Created by Rawan Elsayed on 01/11/2024.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    @IBOutlet weak var newsImg: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
    }
    

}
