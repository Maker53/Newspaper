//
//  NewsViewController.swift
//  News
//
//  Created by Станислав on 05.02.2022.
//

import UIKit

protocol NewsDetailViewControllerDelegate {
    func reloadData()
}

class NewsViewController: UITableViewController {

    // MARK: - Private Properties
    private var news: News!
    private var currentPage = 1
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchStoredData()
        setupRefreshControl()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news?.articles.count ?? 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        let article = news?.articles[indexPath.row]
        cell.configure(with: article)
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let cell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
        let article = news?.articles[indexPath.row]
        
        guard let newsDetailVC = segue.destination as? NewsDetailViewController else { return }
        newsDetailVC.article = article
        
        cell.updateViewsCounterValue(forKey: article?.url ?? "")
        newsDetailVC.counter = cell.viewsCounter
        newsDetailVC.delegate = self
    }
    
    // MARK: - IB Actions
    @IBAction func updateData(_ sender: UIBarButtonItem) {
        if sender.tag == 1, currentPage < 5 {
            currentPage += 1
            fetchStoredData()
        } else if sender.tag == 0, currentPage > 1 {
            currentPage -= 1
            fetchStoredData()
        }
    }
    
    // MARK: - Private Methods
    private func fetchData(forPage page: Int) {
        NetworkManager.shared.fetch(dataType: News.self, forPage: page) { result in
            switch result {
            case .success(let type):
                self.news = type
                self.tableView.reloadData()
                StorageManager.shared.save(news: type, forPageKey: "\(self.currentPage)")
                if self.refreshControl != nil {
                    self.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchStoredData() {
        if let newsForPage = StorageManager.shared.fetchNews(forPageKey: "\(currentPage)") {
            news = newsForPage
            tableView.reloadData()
        } else {
            fetchData(forPage: currentPage)
        }
    }
}

// MARK: - Refresh Control
extension NewsViewController {
    @objc private func downloadData() {
        fetchData(forPage: currentPage)
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(downloadData), for: .valueChanged)
    }
}

// MARK: - NewsDetailViewControllerDelegate
extension NewsViewController: NewsDetailViewControllerDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}
