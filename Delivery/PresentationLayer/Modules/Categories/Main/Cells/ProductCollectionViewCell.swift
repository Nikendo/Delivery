//
//  ProductCollectionViewCell.swift
//  Delivery
//
//  Created by Shmatov Nikita on 29.07.2024.
//

import UIKit

public protocol ProductCollectionViewCellDelegate: AnyObject {
    func addToFavorite(id: String)
    func addToCart(id: String)
}

public class ProductCollectionViewCell: UICollectionViewCell {
    public static let cellIdentifier: String = "ProductCollectionViewCell"

    private weak var delegate: ProductCollectionViewCellDelegate?

    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var favoriteButton: UIButton = {
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.baseBackgroundColor = .systemBackground
        configuration.baseForegroundColor = .secondaryLabel
        configuration.background.strokeColor = .systemGray2
        configuration.background.strokeWidth = 1.0
        configuration.image = UIImage(systemName: "heart")
        configuration.imagePlacement = .all
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var cartButton: UIButton = {
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.baseBackgroundColor = UIColor(resource: ._0_BCE_83)
        configuration.image = UIImage(systemName: "cart")
        configuration.imagePlacement = .all
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [favoriteButton, cartButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
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
        favoriteButton.configuration?.image = UIImage(systemName: "heart")
        productImageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
    }

    public func configure(
        product: Product,
        using loader: ImageLoaderProtocol,
        delegate: ProductCollectionViewCellDelegate
    ) {
        self.delegate = delegate
        favoriteButton.addAction(
            UIAction(handler: { [weak self] _ in
                self?.delegate?.addToFavorite(id: product.id) }),
            for: .touchUpInside
        )
        favoriteButton.configuration?.image = UIImage(systemName: product.isFavorite ? "heart.fill" : "heart")

        cartButton.addAction(
            UIAction(handler: { [weak self] _ in self?.delegate?.addToCart(id: product.id) }),
            for: .touchUpInside
        )

        if let imageUrlString = product.imageUrls.last, let url = URL(string: imageUrlString) {
            productImageView.setImage(from: url, using: loader)
        } else {
            productImageView.image = UIImage(resource: .categoryVegetables)
        }

        titleLabel.text = product.name
        let attributedString = NSMutableAttributedString(
            string: "\(product.price) ",
            attributes: [.font: UIFont.systemFont(ofSize: 22, weight: .bold)]
        )
        attributedString.append(NSAttributedString(
            string: "€ / \(product.quantityType)",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16),
                .foregroundColor: UIColor.secondaryLabel
            ]
        ))
        priceLabel.attributedText = attributedString
    }
}

private extension ProductCollectionViewCell {
    func setupViews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(buttonsStackView)

        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            productImageView.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -10),

            titleLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            priceLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 10),
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: buttonsStackView.topAnchor, constant: -4),

            buttonsStackView.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 10),
            buttonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            buttonsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
