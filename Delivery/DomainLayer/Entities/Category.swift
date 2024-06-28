//
//  Category.swift
//  Delivery
//
//  Created by Shmatov Nikita on 01.07.2024.
//

import Foundation


public struct Category: Hashable, Decodable {
    public let id: String
    public let name: String
    public let count: Int
    public let imageUrl: String?

    public init(id: String, name: String, count: Int, imageUrl: String? = nil) {
        self.id = id
        self.name = name
        self.count = count
        self.imageUrl = imageUrl
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case count
        case imageUrl = "image_url"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.count = try container.decode(Int.self, forKey: .count)
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
    }
}
