//
//  News.swift
//  News
//
//  Created by Станислав on 05.02.2022.
//

import Foundation

struct News: Codable {
    var articles: [Article]
}

struct Article: Codable {
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
}
