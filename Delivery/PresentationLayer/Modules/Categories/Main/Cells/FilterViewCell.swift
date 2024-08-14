//
//  FilterViewCell.swift
//  Delivery
//
//  Created by Shmatov Nikita on 14.08.2024.
//

import UIKit

public class FilterViewCell: UICollectionViewCell {
    public static let cellIdentifier: String = "FilterViewCell"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .accent
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
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
        titleLabel.text = nil
        contentView.backgroundColor = .clear
    }

    public func configure(_ filter: FilterItem) {
        titleLabel.text = filter.text
        contentView.backgroundColor = filter.selected ? UIColor(resource: .E_2_CBFF) : .clear
    }
}

private extension FilterViewCell {
    func setupViews() {
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])

        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = contentView.bounds.height / 2
        contentView.clipsToBounds = false
    }
}
