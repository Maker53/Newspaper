//
//  NewsImageView.swift
//  News
//
//  Created by Станислав on 05.02.2022.
//

import UIKit

class NewsImageView: UIImageView {
    func fetchImage(from url: String) {
        guard let imageURL = URL(string: url) else {
            image = #imageLiteral(resourceName: "noImage")
            return
        }
        
        // Use image from cache
        if let cachedImage = getCachedImage(from: imageURL) {
            image = cachedImage
            return
        }
        
        // Download image from url
        ImageManager.shared.fetchImage(from: imageURL) { result in
            switch result {
            case .success((let data, let response)):
                self.saveDataToCache(with: data, and: response)
                if imageURL.lastPathComponent == response.url?.lastPathComponent {
                    self.image = UIImage(data: data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        let cachedURLResponse = CachedURLResponse(response: response, data: data)
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        URLCache.shared.storeCachedResponse(cachedURLResponse, for: request)
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        guard let cachedResponse = URLCache.shared.cachedResponse(for: request) else { return nil }
        guard url.lastPathComponent == cachedResponse.response.url?.lastPathComponent else { return nil }
        return UIImage(data: cachedResponse.data)
    }
}
