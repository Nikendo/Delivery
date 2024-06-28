//
//  CategoriesCoordinatorProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 02.07.2024.
//

import UIKit


public protocol CategoriesCoordinatorProtocol: Coordinator {
    func toCategoryScreen(category: Category)
}
