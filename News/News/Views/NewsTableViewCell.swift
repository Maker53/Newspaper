//
//  NewsTableViewCell.swift
//  News
//
//  Created by Станислав on 05.02.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var newsTitleLabel: UILabel!
    @IBOutlet var viewsCounterLabel: UILabel!
    @IBOutlet var newsImage: NewsImageView! {
        didSet {
            newsImage.backgroundColor = .systemGray
            newsImage.layer.cornerRadius = 10
        }
    }
    
    var viewsCounter = 0
        
    func configure(with article: Article?) {
        getViewsCounterValue(forKey: article?.url ?? "")
        newsTitleLabel.text = article?.title ?? ""
        viewsCounterLabel.text = "\(viewsCounter)"
        newsImage.fetchImage(from: article?.urlToImage ?? "")
    }
    
    func updateViewsCounterValue(forKey key: String) {
        viewsCounter += 1
        StorageManager.shared.saveViewsCounterValue(count: viewsCounter, forKey: key)
    }
    
    func getViewsCounterValue(forKey key: String) {
        viewsCounter = StorageManager.shared.fetchViewsCounterValue(forKey: key)
    }
}
