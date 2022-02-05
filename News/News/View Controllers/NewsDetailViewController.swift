//
//  NewsDetailViewController.swift
//  News
//
//  Created by Станислав on 04.02.2022.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet var newsTitleLabel: UILabel!
    @IBOutlet var descriptionNewsLabel: UILabel!
    @IBOutlet var linkToNewsLabel: UILabel!
    @IBOutlet var newsImage: NewsImageView!
    @IBOutlet var viewsConter: UILabel!
    
    var article: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTitleLabel.text = article.title
        descriptionNewsLabel.text = article.description
        linkToNewsLabel.text = article.url
        
        newsImage.fetchImage(from: article?.urlToImage ?? "")
    }
}

