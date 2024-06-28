//
//  ImageLoader.swift
//  Delivery
//
//  Created by Shmatov Nikita on 12.07.2024.
//

import UIKit


public protocol ImageLoading: AnyObject {
    func execute(from url: URL) async throws -> UIImage
}

final class NetworkImageLoader: ImageLoading {
    func execute(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        guard let image = UIImage(data: data) else { throw URLError(.cannotDecodeContentData) }
        return image
    }
}

public protocol ImageLoaderProtocol: AnyObject {
    func load(from url: URL) async throws -> UIImage
}

final class ImageLoader: ImageLoaderProtocol {
    private let imageCache: ImageCacheProtocol
    private let loader: ImageLoading

    init(imageCache: ImageCacheProtocol = ImageCache(), loader: ImageLoading = NetworkImageLoader()) {
        self.imageCache = imageCache
        self.loader = loader
    }

    func load(from url: URL) async throws -> UIImage {
        // Check if the imageCache has an image by URL
        if let cachedImage = await imageCache.image(forKey: url) {
            // Return cached image
            return cachedImage
        } else {
            // Load an image from network by URL
            let networkImage = try await loader.execute(from: url)

            // Insert an image to imageCache by URL
            await imageCache.insert(networkImage, forKey: url)

            return networkImage
        }
    }
}

