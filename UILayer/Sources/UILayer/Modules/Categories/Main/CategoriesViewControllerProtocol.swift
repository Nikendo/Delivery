//
//  CategoriesViewControllerProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 02.07.2024.
//


@MainActor
public protocol CategoriesViewControllerProtocol: AnyObject {
    var viewModel: CategoriesViewModelProtocol { get }
}
