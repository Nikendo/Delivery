//
//  ProductViewControllerProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 22.08.2024.
//


@MainActor
public protocol ProductViewControllerProtocol: AnyObject {
    var viewModel: ProductViewModelProtocol { get }
}
