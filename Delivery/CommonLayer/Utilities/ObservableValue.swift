//
//  ObservableValue.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import Combine


public final class ObservableValue<T> {
    @Published public var value: T

    public init(value: T) {
        self.value = value
    }
}
