//
//  PaymentsFeature.swift
//  TitleTestApp
//
//  Created by Matt on 3/13/25.
//

import ComposableArchitecture
import SwiftUI

struct PaymentFeature: Reducer {
    @Dependency(\.paymentsClient) var paymentsClient

    
    struct State: Equatable {
        var selectedSubscriptionIndex = 0
        var availablePlans: [PriceModel] = []
        var isProcessing = false
        var paymentSuccess: Bool?
        var isLoading: Bool = true
        var error: String? = nil
    }

    enum Action: Equatable {
        case loadPlans
        case paymentsLoaded([PriceModel])
        case loadFailed(String)
        case paymentInfoChanged(Int)
        case privacyPolicyTapped
        case termsOfUseTapped
        case processPayment
        case paymentProcessed(Bool)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .loadPlans:
                state.isLoading = true
                    print("Loading plans...")
                    return .run { send in
                        do {
                            let plans = try await paymentsClient.fetchPlans()
                            print("Plans loaded: \(plans)")
                            await send(.paymentsLoaded(plans))
                        } catch {
                            print("Failed to load plans: \(error.localizedDescription)")
                            await send(.loadFailed(error.localizedDescription))
                        }
                    }
            case let .paymentsLoaded(plans):
                state.isLoading = false
                state.availablePlans = plans
                return .none
            case let .loadFailed(error):
                state.isLoading = false
                state.error = error
                return .none
            case let .paymentInfoChanged(info):
                state.selectedSubscriptionIndex = info
                return .none
            case .privacyPolicyTapped:
                return .none
            case .termsOfUseTapped:
                return .none
            case .processPayment:
                state.isProcessing = true
                return .run { [info = state.selectedSubscriptionIndex] send in
                    let success = await processPayment(info)
                    await send(.paymentProcessed(success))
                }
            case let .paymentProcessed(success):
                state.isProcessing = false
                state.paymentSuccess = success
                return .none
            }
        }
    }

    func processPayment(_ info: Int) async -> Bool {
        try? await Task.sleep(nanoseconds: 100000)
        return true
    }
}
