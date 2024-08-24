//
//  ProductViewModelProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 22.08.2024.
//

import Foundation


public protocol ProductViewModelProtocol: AnyObject {
    func fetchProduct()
    func addToFavorite()
    func addToCart()
}
