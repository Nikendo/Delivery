//
//  Coordinator.swift
//  Delivery
//
//  Created by Shmatov Nikita on 28.06.2024.
//

import UIKit


public protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}
