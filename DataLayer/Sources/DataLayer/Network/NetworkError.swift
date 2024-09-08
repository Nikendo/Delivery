//
//  NetworkError.swift
//  Delivery
//
//  Created by Shmatov Nikita on 06.09.2024.
//

import Foundation


public enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
    case serverError(statusCode: Int)
}
