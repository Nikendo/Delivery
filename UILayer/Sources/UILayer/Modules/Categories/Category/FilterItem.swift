//
//  FilterItem.swift
//  Delivery
//
//  Created by Shmatov Nikita on 14.08.2024.
//

public struct FilterItem: Hashable, Sendable {
    public let id: String
    public let text: String
    public let selected: Bool

    public init(id: String, text: String, selected: Bool) {
        self.id = id
        self.text = text
        self.selected = selected
    }
}
