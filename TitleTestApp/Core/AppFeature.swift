//
//  AppFeature.swift
//  TitleTestApp
//
//  Created by Matt on 3/12/25.
//

import ComposableArchitecture
import SwiftUI

struct AppFeature: Reducer {
    @CasePathable
    enum State: Equatable {
        case intro(IntroFeature.State)
        case onboarding(OnboardingFeature.State)
        case quiz(QuizFeature.State)
        case payment(PaymentFeature.State)
    }

    @CasePathable
    enum Action: Equatable {
        case intro(IntroFeature.Action)
        case onboarding(OnboardingFeature.Action)
        case quiz(QuizFeature.Action)
        case payment(PaymentFeature.Action)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .intro(.navigateToOnboarding):
                state = .onboarding(OnboardingFeature.State())
                return .none
            case .onboarding(.navigateToQuiz):
                state = .quiz(QuizFeature.State())
                return .none
            case .quiz(.finishQuiz):
                state = .payment(PaymentFeature.State())
                return .none
            default:
                return .none
            }
        }
        .ifCaseLet(\.intro, action: \.intro) {
            IntroFeature()
        }
        .ifCaseLet(\.onboarding, action: \.onboarding) {
            OnboardingFeature()
        }
        .ifCaseLet(\.quiz, action: \.quiz) {
            QuizFeature()
        }
        .ifCaseLet(\.payment, action: \.payment) {
            PaymentFeature()
        }
    }
}

extension AppFeature.State {
    static let initial: AppFeature.State = .intro(IntroFeature.State())
}

