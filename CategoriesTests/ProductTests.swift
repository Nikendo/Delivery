//
//  ProductTests.swift
//  CategoriesTests
//
//  Created by Shmatov Nikita on 19.07.2024.
//

import XCTest
import Delivery

final class ProductTests: XCTestCase {

    func testProductInitialization() {
        // Given
        let id: String = UUID().uuidString
        let imageUrls: [String] = ["A", "B", "C"]
        let name: String = "Carrot"
        let description: String = "A fresh and sweet, tasty carrot from Russia with love."
        let country: String = "Russia"
        let price: Double = 1.1
        let isFavorite: Bool = true
        
        // When
        let product: Product = Product(
            id: id,
            imageUrls: imageUrls,
            name: name,
            description: description,
            country: country,
            price: price,
            isFavorite: isFavorite
        )

        // Then
        XCTAssertEqual(id, product.id, "Product's id property with value: \(product.id) is not equal to given id property with value: \(id)")
        XCTAssertEqual(imageUrls, product.imageUrls, "Product's values of imageUrls property are not equal to given imageUrls property values")
        XCTAssertEqual(name, product.name, "Product's name property with value: \(product.name) is not equal to given name property with value: \(name)")
        XCTAssertEqual(description, product.description, "Product's description property with value: \(product.description) is not equal to given description property with value: \(description)")
        XCTAssertEqual(country, product.country, "Product's country property with value: \(product.country) is not equal to given country property with value: \(country)")
        XCTAssertEqual(price, product.price, "Product's price property with value: \(product.price) is not equal to given price property with value: \(price)")
        XCTAssertEqual(isFavorite, product.isFavorite, "Product's isFavorite property with value: \(product.isFavorite) is not equal to given isFavorite property with value: \(isFavorite)")
    }
}
