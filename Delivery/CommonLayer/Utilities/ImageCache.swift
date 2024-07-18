//
//  ImageCache.swift
//  Delivery
//
//  Created by Shmatov Nikita on 12.07.2024.
//

import UIKit


public protocol ImageCacheProtocol: AnyObject {
    func insert(_ image: UIImage, forKey key: URL) async
    func image(forKey key: URL) async -> UIImage?
    func remove(forKey key: URL) async
    func removeAll(forKey key: URL) async
}

public final actor ImageCache: ImageCacheProtocol {
    private let cache = NSCache<WrappedKey, Entry>()

    public func insert(_ image: UIImage, forKey key: URL) {
        let value = Entry(value: image)
        let key = WrappedKey(key: key)
        cache.setObject(value, forKey: key)
    }
    
    public func image(forKey key: URL) -> UIImage? {
        cache.object(forKey: WrappedKey(key: key))?.value
    }
    
    public func remove(forKey key: URL) {
        cache.removeObject(forKey: WrappedKey(key: key))
    }

    public func removeAll(forKey key: URL) {
        cache.removeAllObjects()
    }
}

private extension ImageCache {
    final class WrappedKey: NSObject {
        let key: URL

        init(key: URL) {
            self.key = key
        }

        override var hash: Int { key.hashValue }

        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else { return false }
            return value.key == key
        }
    }

    final class Entry {
        let value: UIImage

        init(value: UIImage) {
            self.value = value
        }
    }
}
