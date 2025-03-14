//
//  OnboardingFeature.swift
//  TitleTestApp
//
//  Created by Matt on 3/13/25.
//

import ComposableArchitecture

struct OnboardingFeature: Reducer {
    struct State: Equatable {
        var pages: [OnboardingPage] = [
            OnboardingPage(
                id: 0,
                imageName: "firstOnboardingImage",
                title: "Your Personal Stylist",
                description: "who matches you perfectly"
            ),
            OnboardingPage(
                id: 1,
                imageName: "secondOnboardingImage",
                title: "Curated outfits",
                description: "of high quality and multiple brands"
            ),
            OnboardingPage(
                id: 2,
                imageName: "thirdOnboardingImage",
                title: "Weekly Outfit Selections",
                description: "hand-picked by your stylist"
            )
        ]
        var currentPageIndex: Int = 0
    }

    enum Action: Equatable {
        case navigateToQuiz
        case termsOfUseTapped
        case privacyPolicyTapped
        case imageCarouselChanged(Int)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .navigateToQuiz:
                return .none
            case .termsOfUseTapped:
                return .none
            case .privacyPolicyTapped:
                return .none
            case let .imageCarouselChanged(index):
                state.currentPageIndex = index
                return .none
            }
        }
    }
}
