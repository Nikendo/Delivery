//
//  ProductImageCollectionViewCell.swift
//  Delivery
//
//  Created by Shmatov Nikita on 29.08.2024.
//

import UIKit
import DataLayer


public final class ProductImageCollectionViewCell: UICollectionViewCell {
    public static let cellIdentifier: String = "ProductImageCollectionViewCell"

    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
    }

    public func configure(urlString: String, loader: ImageLoaderProtocol) {
        guard let url = URL(string: urlString) else { return }
        productImageView.setImage(from: url, using: loader)
    }
}

private extension ProductImageCollectionViewCell {
    func setupViews() {
        contentView.addSubview(productImageView)

        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
