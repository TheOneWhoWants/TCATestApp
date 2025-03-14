//
//  PriceModel.swift
//  TitleTestApp
//
//  Created by Matt on 3/13/25.
//

import Foundation

struct PriceModel: Equatable {
    let title: String
    let price: Double
    let billingInterval: String
    let productId: String
    
    init(title: String, price: Double, billingInterval: String, productId: String) {
        self.title = title
        self.price = price
        self.billingInterval = billingInterval
        self.productId = productId
    }
}
