//
//  SearchController.swift
//  Delivery
//
//  Created by Shmatov Nikita on 06.07.2024.
//

import UIKit

public final class SearchController: UISearchController {

    public override func viewDidLoad() {
        super.viewDidLoad()

        obscuresBackgroundDuringPresentation = false
        hidesNavigationBarDuringPresentation = false
        searchBar.placeholder = "Search"

        updateAppearance()
    }

    public func updateAppearance() {
        setupLeftView()
        setupRightView()
        setupSearchBarAppearance()
    }

    private func setupLeftView() {
        searchBar.setPositionAdjustment(.init(horizontal: 10, vertical: 0), for: .search)
    }

    private func setupRightView() {
        searchBar.setPositionAdjustment(.init(horizontal: -10, vertical: 0), for: .clear)
    }

    private func setupSearchBarAppearance() {
        searchBar.setTextFieldBackgroundColor(.white)
        searchBar.searchTextField.borderStyle = .roundedRect
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.layer.borderColor = UIColor(resource: .D_9_D_0_E_3).cgColor
        searchBar.searchTextField.layer.cornerRadius = 26
        searchBar.searchTextField.font = .systemFont(ofSize: 17)
        searchBar.searchTextField.clipsToBounds = true
    }
}

fileprivate extension UISearchBar {
    func setTextFieldBackgroundColor(_ color: UIColor) {
        guard
            let textField = value(forKey: "searchField") as? UITextField,
            let backgroundView = textField.subviews.first
        else { return }
        textField.backgroundColor = .white

        backgroundView.backgroundColor = color
        backgroundView.subviews.forEach({ $0.removeFromSuperview() })
    }
}
