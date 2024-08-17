//
//  MockProducts.swift
//  CategoriesTests
//
//  Created by Shmatov Nikita on 19.07.2024.
//

import Foundation
import Delivery

enum MockProducts {
    static var vegetables: [Product] = [
        Product(id: UUID().uuidString, imageUrls: [], name: "Boston Lettuce", description: "A", country: "Spain", price: 1.1, quantityType: "piece", kind: "vegetables", isFavorite: false),
        Product(id: UUID().uuidString, imageUrls: [], name: "Purple Cauliflower", description: "B", country: "France", price: 1.1, quantityType: "piece", kind: "vegetables", isFavorite: false),
        Product(id: UUID().uuidString, imageUrls: [], name: "Savoy Cabbage", description: "C", country: "Mexico", price: 1.1, quantityType: "piece", kind: "vegetables", isFavorite: false),
        Product(id: UUID().uuidString, imageUrls: [], name: "Carrot", description: "D", country: "Russia", price: 1.1, quantityType: "piece", kind: "vegetables", isFavorite: false),
    ]
}
