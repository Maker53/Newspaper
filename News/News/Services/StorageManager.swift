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
    
    func save(article: String) {
        
    }
    
    func fetchArticles() -> [Data] {
        
        return []
    }
}
