//
//  FirebaseCategoriesService.swift
//  Delivery
//
//  Created by Shmatov Nikita on 02.07.2024.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

public final class FirebaseCategoriesService: CategoriesServiceProtocol {
    private let db = Firestore.firestore()

    public func fetchCategories() async throws -> [Category] {
        let collection = db.collection("Categories")
        let documentsSnapshot = try await collection.getDocuments()
        let categories: [Category] = documentsSnapshot.documents.compactMap {
            guard
                let name = $0["name"] as? String,
                let count = $0["count"] as? Int
            else { return nil }
            let id = $0.documentID
            let imageUrl: String? = $0["image_url"] as? String
            return Category(id: id, name: name, count: count, imageUrl: imageUrl)
        }
        return categories
    }
}
