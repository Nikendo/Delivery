//
//  CartViewController.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import UIKit


public class CartViewController: UIViewController {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textColor = UIColor(resource: .A_259_FF)
        label.text = title
        return label
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
