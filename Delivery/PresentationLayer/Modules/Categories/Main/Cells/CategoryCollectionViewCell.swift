//
//  CategoryCollectionViewCell.swift
//  Delivery
//
//  Created by Shmatov Nikita on 02.07.2024.
//

import UIKit

@MainActor
public final class CategoryCollectionViewCell: UICollectionViewCell {
    public static let cellIdentifier: String = "CategoryCollectionViewCell"
    
    private lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        return label
    }()
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, countLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
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
        categoryImageView.image = nil
        titleLabel.text = nil
        countLabel.text = nil
    }

    public func configure(category: Category, using loader: ImageLoaderProtocol) {
        if let imageUrlString = category.imageUrl, let url = URL(string: imageUrlString) {
            categoryImageView.setImage(from: url, using: loader)
        } else {
            categoryImageView.image = UIImage(resource: .categoryVegetables)
        }

        titleLabel.text = category.name
        countLabel.text = "(\(category.count))"
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        contentView.layer.borderColor = UIColor(resource: .D_9_D_0_E_3).cgColor
        contentView.layer.borderWidth = 1
    }

    private func setupViews() {
        contentView.addSubview(categoryImageView)
        contentView.addSubview(descriptionStackView)

        NSLayoutConstraint.activate([
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.79),
            descriptionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionStackView.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 10),
            descriptionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
