//
//  StorageManager.swift
//  News
//
//  Created by Станислав on 05.02.2022.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let key = "Article"
    
    private init() {}
    
    func save(article: Data) {
        var articles = fetchArticles()
        articles.append(article)
        userDefaults.set(articles, forKey: key)
    }
    
    func fetchArticles() -> [Data] {
        if let articles = userDefaults.value(forKey: key) as? [Data] {
            return articles
        }
        return []
    }
    
    func deleteArticle(at index: Int) {
        var articles = fetchArticles()
        articles.remove(at: index)
        userDefaults.set(articles, forKey: key)
    }
}
