//
//  UIImage+Async.swift
//  Delivery
//
//  Created by Shmatov Nikita on 07.07.2024.
//

import UIKit


extension UIImage {
    public static func loadImage(from url: URL) async throws -> UIImage? {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return nil
        }
        return UIImage(data: data)
    }
}

extension UIImageView {
    public func setImage(from url: URL, using loader: ImageLoaderProtocol) {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])

        Task {
            activityIndicator.startAnimating()
            let loadedImageData = try await loader.load(from: url)
            guard let image = UIImage(data: loadedImageData) else { return }
            DispatchQueue.main.async { [weak self] in
                activityIndicator.stopAnimating()
                self?.image = image
            }
        }
    }
}
