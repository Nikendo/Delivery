//
//  ImageLoader.swift
//  Delivery
//
//  Created by Shmatov Nikita on 12.07.2024.
//

import Foundation


public protocol ImageLoading: AnyObject {
    func execute(from url: URL) async throws -> Data
}

public final class NetworkImageLoader: ImageLoading {
    
    public init() {}
    
    public func execute(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return data
    }
}

public protocol ImageLoaderProtocol: AnyObject {
    func load(from url: URL) async throws -> Data
}

public final class ImageLoader: ImageLoaderProtocol {
    private let imageCache: ImageCacheProtocol
    private let loader: ImageLoading

    public init(imageCache: ImageCacheProtocol = ImageCache(), loader: ImageLoading = NetworkImageLoader()) {
        self.imageCache = imageCache
        self.loader = loader
    }

    public func load(from url: URL) async throws -> Data {
        // Check if the imageCache has an image by URL
        if let cachedImageData = await imageCache.image(forKey: url) {
            // Return cached image
            return cachedImageData
        } else {
            // Load an image from network by URL
            let networkImageData = try await loader.execute(from: url)

            // Insert an image to imageCache by URL
            await imageCache.insert(networkImageData, forKey: url)

            return networkImageData
        }
    }
}

