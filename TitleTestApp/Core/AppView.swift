//
//  AppView.swift
//  TitleTestApp
//
//  Created by Matt on 3/12/25.
//

import ComposableArchitecture
import SwiftUI

struct AppView: View {
    let store: StoreOf<AppFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                SwitchStore(store) { state in
                    switch state {
                    case .intro:
                        CaseLet(/AppFeature.State.intro, action: AppFeature.Action.intro) { store in
                            IntroView(store: store)
                        }
                    case .onboarding:
                        CaseLet(/AppFeature.State.onboarding, action: AppFeature.Action.onboarding) { store in
                            OnboardingView(store: store)
                                .transition(.slide)
                        }
                    case .quiz(let state):
                        CaseLet(/AppFeature.State.quiz, action: AppFeature.Action.quiz) { store in
                            QuizView(store: store)
                                .transition(.slide)
                        }
                    case .payment:
                        CaseLet(/AppFeature.State.payment, action: AppFeature.Action.payment) { store in
                            PaymentView(store: store)
                                .transition(.move(edge: .top))
                        }
                    }
                }
            }
            .animation(.easeInOut(duration: 0.5), value: viewStore.state)
        }
    }
}

