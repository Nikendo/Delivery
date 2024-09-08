//
//  TabBarItems.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import UIKit

enum TabBarItems: Int, CaseIterable {
    case categories, cart, profile
}

extension TabBarItems {
    var title: String {
        switch self {
        case .categories: "Categories"
        case .cart: "Cart"
        case .profile: "Profile"
        }
    }

    var image: UIImage? {
        switch self {
        case .categories: UIImage(systemName: "square.grid.2x2")?.withTintColor(.A_259_FF.withAlphaComponent(0.6))
        case .cart: UIImage(systemName: "cart")?.withTintColor(.A_259_FF.withAlphaComponent(0.6))
        case .profile: UIImage(systemName: "person")?.withTintColor(.A_259_FF.withAlphaComponent(0.6))
        }
    }

    var selectedImage: UIImage? {
        switch self {
        case .categories: UIImage(systemName: "square.grid.2x2.fill")?.withTintColor(.A_259_FF)
        case .cart: UIImage(systemName: "cart.fill")?.withTintColor(.A_259_FF)
        case .profile: UIImage(systemName: "person.fill")?.withTintColor(.A_259_FF)
        }
    }
}
