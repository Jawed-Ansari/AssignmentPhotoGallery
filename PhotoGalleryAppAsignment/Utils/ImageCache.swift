//
//  ImageCache.swift
//  PhotoGalleryAppAsignment
//
//  Created by Muhhmmd Jawed Ansari on 28/02/26.
//

import Foundation
import UIKit

final class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}

extension UIImageView {
    func loadImage(url: String) {
        if let cached = ImageCache.shared.object(forKey: url as NSString) {
            self.image = cached
            return
        }

        guard let imageURL = URL(string: url) else { return }

        URLSession.shared.dataTask(with: imageURL) { data, _, _ in
            guard let data, let image = UIImage(data: data) else { return }
            ImageCache.shared.setObject(image, forKey: url as NSString)

            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
