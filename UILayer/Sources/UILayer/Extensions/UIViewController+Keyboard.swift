//
//  UIViewController+Keyboard.swift
//  Delivery
//
//  Created by Shmatov Nikita on 07.07.2024.
//

import UIKit

extension UIViewController {
    func setupHideKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
