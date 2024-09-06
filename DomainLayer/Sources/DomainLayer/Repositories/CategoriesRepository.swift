//
//  CategoriesRepository.swift
//  Delivery
//
//  Created by Shmatov Nikita on 02.07.2024.
//


public protocol CategoriesRepository: AnyObject {
    func fetchCategories() async throws -> [ProductCategory]
}
