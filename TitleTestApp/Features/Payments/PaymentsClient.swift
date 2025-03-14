//
//  PaymentsClient.swift
//  TitleTestApp
//
//  Created by Matt on 3/13/25.
//

import Foundation
import ComposableArchitecture

struct PaymentsClient {
    var fetchPlans: @Sendable () async throws -> [PriceModel]
    var openPaywall: @Sendable (PriceModel) async throws -> Bool
}

extension PaymentsClient: DependencyKey {
    static let liveValue: PaymentsClient = PaymentsClient(
        fetchPlans: {
            let mockPlans: [PriceModel] = [
                .init(title: "FOR FREE", price: 0, billingInterval: "then $29.99 billed monthly", productId: "trial"),
                .init(title: "Quarterly", price: 59.99, billingInterval: "billed quarterly", productId: "quarterly"),
                .init(title: "Lifetime", price: 99.99, billingInterval: "one-time payment", productId: "trial")
            ]
            return mockPlans
        },
        openPaywall: { selection in
            try await Task.sleep(nanoseconds: 10000)
            return true
        }
    )
}

extension DependencyValues {
    var paymentsClient: PaymentsClient {
        get { self[PaymentsClient.self] }
        set { self[PaymentsClient.self] = newValue }
    }
}
