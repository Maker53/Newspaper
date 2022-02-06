//
//  NewsDetailViewController.swift
//  News
//
//  Created by Станислав on 04.02.2022.
//

import UIKit

class NewsDetailViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var newsTitleLabel: UILabel!
    @IBOutlet var newsImage: NewsImageView!
    @IBOutlet var newsLinkTextView: UITextView!
    @IBOutlet var newsDescriptionTextView: UITextView!
    @IBOutlet var viewsCounter: UILabel!
    
    // MARK: - Public Properties
    var article: Article!
    var delegate: NewsDetailViewControllerDelegate!
    var counter = 0
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTitleLabel.text = article.title
        newsDescriptionTextView.text = article.description
        newsLinkTextView.text = article.url
        viewsCounter.text = "\(counter)"
        newsImage.fetchImage(from: article?.urlToImage ?? "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate.reloadData()
    }
}

