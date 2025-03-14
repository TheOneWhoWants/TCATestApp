//
//  PaymentsView.swift
//  TitleTestApp
//
//  Created by Matt on 3/13/25.
//

import ComposableArchitecture
import SwiftUI


struct PaymentView: View {
    let store: StoreOf<PaymentFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            if viewStore.isLoading {
                ProgressView("Loading plans...")
            } else if let error = viewStore.error {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                VStack(spacing: 0) {
                    Image("paymentsBackgroundImage")
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                    
                    textView
                    
                    Spacer()
                    
                    subscriptionPlansView(viewStore)
                        .padding(.bottom, 20)
                    
                    VStack(spacing: 20) {
                        CommonButton(title: "CONTINUE", isSmallButon: true) {
                            viewStore.send(.processPayment)
                        }
                        footerLinksView(viewStore)
                    }
                }
                .background(ignoresSafeAreaEdges: .top)
            }
        }
        .onAppear {
            store.send(.loadPlans)
        }
    }
        
    private var textView: some View {
        VStack {
            HStack(spacing: 10) {
                ForEach(1...5, id: \.self) { _ in
                    Image("starImage")
                        .resizable()
                        .frame(width: 16, height: 16)
                }
            }
            Text("FIRST MEETING WITH A STYLIST")
                .font(Fonts.smallPaymentsDescriptionFont)
                .foregroundStyle(.customBlack)
            
            Text("Tessa caught my style with the first outfit she put together. Although we changed a few things she was great at finding what works for me!")
                .font(Fonts.ultraSmallPaymentsDescriptionFont)
                .foregroundStyle(.paymentsGray)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 40)
    }
    
    private func subscriptionPlansView(_ viewStore: ViewStore<PaymentFeature.State, PaymentFeature.Action>) -> some View {
        VStack(spacing: 20) {
            HStack {
                ForEach(viewStore.availablePlans.indices, id: \.self) { index in
                    PricingPlanView(
                        plan: viewStore.availablePlans[index],
                        isSelected: viewStore.selectedSubscriptionIndex == index,
                        action: {
                            viewStore.send(.paymentInfoChanged(index))
                        }
                    )
                }
            }
            Text("Auto-renewable. Cancel anytime.")
                .font(Fonts.smallQuizDescriptionFont)
                .foregroundStyle(.paymentsGray)
                .padding(.bottom, 5)
        }
    }
    
    private func footerLinksView(_ viewStore: ViewStore<PaymentFeature.State, PaymentFeature.Action>) -> some View {
        HStack {
            Button {
                viewStore.send(.termsOfUseTapped)
            } label: {
                Text("Terms of use")
                    .underline(true, color: Color.paymentsGray)
            }
            Text("|")
            Button {
                viewStore.send(.privacyPolicyTapped)
            } label: {
                Text("Privacy Policy")
                    .underline(true, color: Color.paymentsGray)
            }
        }
        .font(Fonts.smallQuizButtonFont)
        .foregroundStyle(.paymentsGray)
    }
}

#Preview {
    PaymentView(store: Store(initialState: PaymentFeature.State(), reducer: {
        PaymentFeature()
            .dependency(\.paymentsClient, .testValue)
    }))
}

