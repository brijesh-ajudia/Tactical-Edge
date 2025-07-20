//
//  ImageLoader.swift
//  Demo_Weather
//
//  Created by Brijesh Ajudia on 20/07/25.
//

import Foundation
import SDWebImage

class ImageLoader {
    static func loadImage(from urlString: String, into imageView: UIImageView) {
        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL: \(urlString)")
            return
        }

        imageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo")) { image, error, _, _ in
            if let error = error {
                print("🔴 Image load error: \(error.localizedDescription)")
            }
        }
    }
}
