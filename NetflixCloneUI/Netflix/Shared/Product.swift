//
//  Welcome.swift
//  SwiftfulSwiftUiPractice
//
//  Created by apple on 06/05/25.
//

import Foundation


struct ProductArray: Codable {
    var products: [Product]?
    var total, skip, limit: Int?
}

// MARK: - Product
struct Product: Codable, Identifiable {
    var id: Int?
    var title, description: String?
    var category: String?
    var price, discountPercentage, rating: Double?
    var stock: Int?
    var tags: [String]?
    var brand, sku: String?
    var weight: Int?
    var warrantyInformation, shippingInformation: String?
    var images: [String]?
    var thumbnail: String?
    
    var firstImage:String{
        images?.first ?? Constants.randomImage
    }
    

    let recentlyAdded:Bool = {
        return Int.random(in: 1...4) == 1
    }()
    
    static var mock:Product{
        Product(id: 1234,
                title : "Example Product title",
                description: "Example Product description",
                category: "Electronic Device",
                price: 999,
                discountPercentage: 16,
                rating: 4.6, stock: 50,
                tags: [],
                brand: "Apple",
                sku: "",
                weight: 50,
                warrantyInformation: "",
                shippingInformation: "",
                images: [Constants.randomImage, Constants.randomImage],
                thumbnail: Constants.randomImage)
    }
}


struct ProductRow:Identifiable{
    let id = UUID().uuidString
    let title:String
    let products:[Product]
}
