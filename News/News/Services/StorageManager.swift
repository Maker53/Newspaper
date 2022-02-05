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
    
    func save(news: News) {
        var newsList = fetchArticles()
        newsList.append(news)
        guard let data = try? JSONEncoder().encode(newsList) else { return }
        userDefaults.set(data, forKey: key)
    }
    
    func fetchArticles() -> [News] {
        guard let data = userDefaults.data(forKey: key) else { return [] }
        guard let newsList = try? JSONDecoder().decode([News].self, from: data) else { return [] }
        return newsList
    }
    
    func deleteArticle(at index: Int) {
        var newsList = fetchArticles()
        newsList.remove(at: index)
        guard let data = try? JSONEncoder().encode(newsList) else { return }
        userDefaults.set(data, forKey: key)
    }
}
