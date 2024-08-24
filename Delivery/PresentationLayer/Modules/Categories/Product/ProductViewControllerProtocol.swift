//
//  ProductViewControllerProtocol.swift
//  Delivery
//
//  Created by Shmatov Nikita on 22.08.2024.
//

import Foundation

public protocol ProductViewControllerProtocol: AnyObject {
    var viewModel: ProductViewModelProtocol { get }
}
