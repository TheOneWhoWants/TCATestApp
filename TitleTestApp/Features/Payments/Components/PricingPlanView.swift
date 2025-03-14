//
//  PricingPlanView.swift
//  TitleTestApp
//
//  Created by Matt on 3/13/25.
//

import SwiftUI

struct PricingPlanView: View {
    let plan: PriceModel
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 5) {
                planTitleAndPriceView
                
                Spacer()
                
                Text(plan.billingInterval)
                    .font(Fonts.smallQuizButtonFont)
                    .foregroundStyle(.quizBlack)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .layoutPriority(1)
                    .frame(width: 100, height: 50)
            }
            .padding()
            .frame(width: 108, height: 128)
            .overlay(
                ZStack {
                    Rectangle()
                        .stroke(isSelected ? Color.quizBlack : Color.gray, lineWidth: 1)
                    
                    if plan.price == 0 {
                        hotDealBadgeView
                    }
                }
            )
        }
    }
    
    private var planTitleAndPriceView: some View {
        let title = plan.price == 0 ? "TRY 3 DAYS" : plan.title
        let price = plan.price == 0 ? "FOR FREE" : "$ \(plan.price)"
        
        return VStack(spacing: 5) {
            Text(title)
                .font(Fonts.smallPaymentsDescriptionFont)
                .bold(price != "FOR FREE")
                .foregroundColor(.quizBlack)
                .fixedSize(horizontal: true, vertical: true)
                .padding(.top)
            
            Text(price)
                .font(Fonts.smallPaymentsDescriptionFont)
                .bold(price == "FOR FREE")
                .foregroundColor(.quizBlack)
        }
    }
    
    private var hotDealBadgeView: some View {
        VStack {
            HStack {
                Spacer()
                Text("HOT DEAL 🔥")
                    .font(Fonts.smallBoldTextFont)
                    .foregroundColor(.white)
                Spacer()
            }
            .background {
                Rectangle()
                    .fill(.quizBlack)
                    .frame(height: 23)
            }
            Spacer()
        }
        .offset(y: -15)
    }
}
