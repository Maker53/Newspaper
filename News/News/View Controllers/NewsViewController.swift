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
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData(from: Link(page: "1").api)
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
    
    // MARK: - Private Methods
    private func fetchData(from url: String) {
        NetworkManager.shared.fetch(dataType: News.self, from: url) { result in
            switch result {
            case .success(let data):
                self.news = data
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

