//
//  Product.swift
//  Delivery
//
//  Created by Shmatov Nikita on 19.07.2024.
//

import Foundation


public struct Product: Hashable, Codable, Sendable {
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrls = "image_urls"
        case name
        case description
        case country
        case price
        case averageWeight = "average_weight"
        case weightUnit = "weight_unit"
        case quantityType = "quantity_type"
        case kind
        case isFavorite = "is_favorite"
    }

    public let id: String
    public let imageUrls: [String]
    public let name: String
    public let description: String
    public let country: String
    public let price: Double
    public let averageWeight: Double
    public let weightUnit: String
    public let quantityType: String
    public let isFavorite: Bool
    public let kind: String

    public init(
        id: String,
        imageUrls: [String],
        name: String,
        description: String,
        country: String,
        price: Double,
        averageWeight: Double,
        weightUnit: String,
        quantityType: String,
        kind: String,
        isFavorite: Bool
    ) {
        self.id = id
        self.imageUrls = imageUrls
        self.name = name
        self.description = description
        self.country = country
        self.price = price
        self.averageWeight = averageWeight
        self.weightUnit = weightUnit
        self.quantityType = quantityType
        self.kind = kind
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
        self.averageWeight = try container.decode(Double.self, forKey: .averageWeight)
        self.weightUnit = try container.decode(String.self, forKey: .weightUnit)
        self.quantityType = try container.decode(String.self, forKey: .quantityType)
        self.kind = try container.decode(String.self, forKey: .kind)
        self.isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
    }
}
