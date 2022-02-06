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
    @IBOutlet var viewsCounter: UILabel!
    
    var article: Article!
    var delegate: NewsDetailViewControllerDelegate!
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTitleLabel.text = article.title
        descriptionNewsLabel.text = article.description
        linkToNewsLabel.text = article.url
        viewsCounter.text = "\(counter)"
        
        newsImage.fetchImage(from: article?.urlToImage ?? "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate.reloadData()
    }
}

