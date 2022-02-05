//
//  News.swift
//  News
//
//  Created by Станислав on 05.02.2022.
//

import Foundation

struct News: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
}

struct Link {
    let api: String
    
    init(page: Int) {
        api = "https://newsapi.org/v2/everything?domains=bloomberg.com&page=\(page)&apiKey=cc18ddf89acd415ea93001a81c07bc96"
    }
}


