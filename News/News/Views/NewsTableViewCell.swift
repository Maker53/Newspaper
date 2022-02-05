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
    
    var viewsCount = 0
        
    func configure(with article: Article?) {
        newsTitleLabel.text = article?.title ?? ""
        viewsCounterLabel.text = "\(viewsCount)"
        newsImage.fetchImage(from: article?.urlToImage ?? "")
    }
}
