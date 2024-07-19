//
//  CategoryViewControllerProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 19.07.2024.
//

import Foundation


public protocol CategoryViewControllerProtocol: AnyObject {
    var viewModel: CategoryViewModelProtocol { get }
}
