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
        if let cachedImage = getImageData(forKey: url) {
            image = cachedImage
            return
        }
        
        // Download image from url
        ImageManager.shared.fetchImage(from: imageURL) { result in
            switch result {
            case .success(let data):
                self.saveData(data: data, withKey: url)
                self.image = UIImage(data: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func saveData(data: Data, withKey key: String) {
        StorageManager.shared.saveImageData(data: data, withKey: key)
    }
    
    private func getImageData(forKey key: String) -> UIImage? {
        guard let data = StorageManager.shared.fetchImageData(forKey: key) else { return nil }
        return UIImage(data: data)
    }
}
