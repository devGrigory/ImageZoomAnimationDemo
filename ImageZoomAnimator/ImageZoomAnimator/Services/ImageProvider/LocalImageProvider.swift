//
//  LocalImageProvider.swift
//  ImageZoomAnimator
//
//  Created by Grigory G. on 28.07.23.
//

import UIKit

// MARK: - ImageFeedProviding Protocol
protocol ImageFeedProviding {
    func fetchImages() -> [ImageItem]
}

// MARK: - LocalImageProvider
final class LocalImageProvider: ImageFeedProviding {
    
    // MARK: - Fetch Images
    func fetchImages() -> [ImageItem] {
        [
            ImageItem(id: UUID(), imageName: "beach_image"),
            ImageItem(id: UUID(), imageName: "forest_image"),
            ImageItem(id: UUID(), imageName: "landscape_image"),
            ImageItem(id: UUID(), imageName: "rock_image"),
            ImageItem(id: UUID(), imageName: "sunset_image")
        ]
    }
}
