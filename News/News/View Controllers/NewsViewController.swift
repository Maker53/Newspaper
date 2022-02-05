//
//  NewsViewController.swift
//  News
//
//  Created by Станислав on 05.02.2022.
//

import UIKit

class NewsViewController: UITableViewController {

    // MARK: - Private Properties
    private var news: News!
    private var numberOfPage = 1
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefreshControl()
        fetchData(from: Link(page: 1).api)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        let article = news?.articles[indexPath.row]
        cell.configure(with: article)
        
        return cell
    }
    
    // MARK: - IB Actions
    @IBAction func updateData(_ sender: UIBarButtonItem) {
        if sender.tag == 1, numberOfPage < 5 {
            numberOfPage += 1
            fetchData(from: Link(page: numberOfPage).api)
        } else if sender.tag == 0, numberOfPage > 1 {
            numberOfPage -= 1
            fetchData(from: Link(page: numberOfPage).api)
        }
    }
    
    // MARK: - Private Methods
    private func fetchData(from url: String) {
        NetworkManager.shared.fetch(dataType: News.self, from: url) { result in
            switch result {
            case .success(let data):
                self.news = data
                self.tableView.reloadData()
                if self.refreshControl != nil {
                    self.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Refresh Control
extension NewsViewController {
    @objc private func downloadData() {
        fetchData(from: Link(page: numberOfPage).api)
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(downloadData), for: .valueChanged)
    }
}
