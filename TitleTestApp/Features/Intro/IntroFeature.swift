//
//  IntroFeature.swift
//  TitleTestApp
//
//  Created by Matt on 3/12/25.
//

import ComposableArchitecture
import SwiftUI

struct IntroFeature: Reducer {
    struct State: Equatable {
        var isProceeding = false
    }

    enum Action: Equatable {
        case navigateToOnboarding
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .navigateToOnboarding:
                state.isProceeding = true
                return .none
            }
        }
    }
}

