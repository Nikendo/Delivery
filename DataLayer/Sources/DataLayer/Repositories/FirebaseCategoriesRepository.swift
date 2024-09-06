//
//  FirebaseCategoriesRepository.swift
//  Delivery
//
//  Created by Shmatov Nikita on 02.07.2024.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import DomainLayer


public final class FirebaseCategoriesRepository: CategoriesRepository {
    private let db = Firestore.firestore()

    public init() {}
    
    public func fetchCategories() async throws -> [ProductCategory] {
        let collection = db.collection("Categories")
        let documentsSnapshot = try await collection.getDocuments()
        let categories: [ProductCategory] = documentsSnapshot.documents.compactMap {
            guard
                let name = $0["name"] as? String,
                let count = $0["count"] as? Int
            else { return nil }
            let id = $0.documentID
            let imageUrl: String? = $0["image_url"] as? String
            return ProductCategory(id: id, name: name, count: count, imageUrl: imageUrl)
        }
        return categories
    }
}
