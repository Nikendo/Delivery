//
//  CollectionFilterView.swift
//  Delivery
//
//  Created by Shmatov Nikita on 14.08.2024.
//


import UIKit


public class CollectionFilterView: UICollectionReusableView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()

    public override var reuseIdentifier: String? { "FilterView" }

    public override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4)
        ])
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(text: String) {
        titleLabel.text = text
    }
}
