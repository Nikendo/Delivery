//
//  FirebaseCategoryRepository.swift
//  Delivery
//
//  Created by Shmatov Nikita on 10.08.2024.
//

import FirebaseFirestore
import DomainLayer


public final class FirebaseCategoryRepository: CategoryRepository {
    private let db = Firestore.firestore()

    public init() {}
    
    public func fetchProducts(for category: ProductCategory) async throws -> [Product] {
        let collection = db.collection("products")
        let documentsSnapshot = try await collection.getDocuments()
        let products: [Product] = documentsSnapshot.documents.compactMap {
            guard
                let name = $0["name"] as? String,
                let country = $0["country"] as? String,
                let description = $0["description"] as? String,
                let imgUrls = $0["image_urls"] as? [String],
                let price = $0["price"] as? Double,
                let averageWeight = $0["average_weight"] as? Double,
                let weightUnit = $0["weight_unit"] as? String,
                let quantityType = $0["quantity_type"] as? String,
                let kind = $0["kind"] as? String,
                let isFavorite = $0["is_favorite"] as? Bool
            else { return nil }
            let id = $0.documentID
            return Product(
                id: id,
                imageUrls: imgUrls,
                name: name,
                description: description,
                country: country,
                price: price,
                averageWeight: averageWeight,
                weightUnit: weightUnit,
                quantityType: quantityType,
                kind: kind,
                isFavorite: isFavorite
            )
        }.filter { $0.kind.lowercased() == category.name.lowercased() }
        return products
    }

    public func updateProduct(_ product: Product) async throws {
        let documentRef = db.collection("products").document(product.id)
        let encoder = JSONEncoder()
        let data = try encoder.encode(product)
        guard let dictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw NSError(domain: "FirebaseProductDataSerializationError", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "Unable to convert data to [String: Any] dictionary."
            ])
        }
        let _ = try await documentRef.updateData(dictionary)
    }
    
    public func addProductToCart(_ product: Product) async throws {
        // a fake implementation of adding the product to the cart
    }
}
