//
//  AddProductToFavoriteUseCaseProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 18.08.2024.
//


public protocol AddProductToFavoriteUseCaseProtocol: AnyObject {
    func execute(product: Product) async throws
}
