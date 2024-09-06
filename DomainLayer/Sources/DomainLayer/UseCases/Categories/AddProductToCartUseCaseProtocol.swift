//
//  AddProductToCartUseCaseProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 06.09.2024.
//

import Foundation

public protocol AddProductToCartUseCaseProtocol: AnyObject {
    func execute(product: Product) async throws
}
