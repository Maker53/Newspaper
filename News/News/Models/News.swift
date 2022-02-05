//
//  News.swift
//  News
//
//  Created by Станислав on 05.02.2022.
//

import Foundation

struct News: Decodable {
    let articles: [Articles]
}

struct Articles: Decodable {
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: Date
}

enum Link: String {
    case newsApi = "https://newsapi.org/v2/everything?domains=bloomberg.com&pageSize=100&apiKey=cc18ddf89acd415ea93001a81c07bc96"
}
