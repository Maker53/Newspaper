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
    
    private init() {}
    
    func save(news: News, forPageKey key: String) {
        guard let data = try? JSONEncoder().encode(news) else { return }
        userDefaults.set(data, forKey: key)
    }
    
    func fetchNews(forPageKey key: String) -> News? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        guard let news = try? JSONDecoder().decode(News.self, from: data) else { return nil }
        return news
    }
    
    func saveImageData(data: Data, withKey key: String) {
        userDefaults.set(data, forKey: key)
    }
    
    func fetchImageData(forKey key: String) -> Data? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        return data
    }
    
    func saveViewsCounterValue(count: Int, forKey key: String) {
        userDefaults.set(count, forKey: key)
    }
    
    func fetchViewsCounterValue(forKey key: String) -> Int {
        return userDefaults.integer(forKey: key)
    }
}
