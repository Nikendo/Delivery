//
//  Product.swift
//  Delivery
//
//  Created by Shmatov Nikita on 19.07.2024.
//

import Foundation


public struct Product: Hashable, Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrls = "image_urls"
        case name
        case description
        case country
        case price
        case isFavorite = "is_favorite"
    }

    public let id: String
    public let imageUrls: [String]
    public let name: String
    public let description: String
    public let country: String
    public let price: Double
    public let isFavorite: Bool

    public init(id: String, imageUrls: [String], name: String, description: String, country: String, price: Double, isFavorite: Bool) {
        self.id = id
        self.imageUrls = imageUrls
        self.name = name
        self.description = description
        self.country = country
        self.price = price
        self.isFavorite = isFavorite
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.imageUrls = try container.decode([String].self, forKey: .imageUrls)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.country = try container.decode(String.self, forKey: .country)
        self.price = try container.decode(Double.self, forKey: .price)
        self.isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
    }
}
