//
//  OnboardingView.swift
//  TitleTestApp
//
//  Created by Matt on 3/13/25.
//

import ComposableArchitecture
import SwiftUI

struct OnboardingView: View {
    let store: StoreOf<OnboardingFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 16) {
                titleView(viewStore)
                Spacer()
                tabBarView(viewStore)
                    .layoutPriority(1)
                Spacer()
                CommonButton(title: "Take a Quiz") {
                    viewStore.send(.navigateToQuiz)
                }
                privacyText(viewStore)
            }
        }
    }
    
    private func privacyText(_ viewStore: ViewStore<OnboardingFeature.State, OnboardingFeature.Action>) -> some View {
        VStack(spacing: 4) {
            Text("By tapping Get started or I already have an account,")
            HStack(spacing: 0) {
                Text("you agree to our ")
                Button {
                    viewStore.send(.termsOfUseTapped)
                } label: {
                    Text("Terms of Use")
                        .foregroundColor(.black)
                        .underline(true, color: .black)
                }
                Text(" and ")
                Button {
                    viewStore.send(.privacyPolicyTapped)
                } label: {
                    Text("Privacy Policy")
                        .foregroundColor(.black)
                        .underline(true, color: .black)
                }
                Text(".")
            }
        }
        .font(Fonts.ultraSmallButtonTextFont)
        .foregroundStyle(.customGray)
        .multilineTextAlignment(.center)
    }
    
    @ViewBuilder private func tabBarView(_ viewStore: ViewStore<OnboardingFeature.State, OnboardingFeature.Action>) -> some View {
        VStack(spacing: 0) {
            TabView(selection: viewStore.binding(
                get: \.currentPageIndex,
                send: OnboardingFeature.Action.imageCarouselChanged
            )) {
                ForEach(viewStore.pages) { page in
                    VStack {
                        Image(page.imageName)
                            .resizable()
                            .scaledToFit()
                    }
                    .tag(page.id)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            CommonPageIndicator(numberOfPages: viewStore.pages.count, currentPage: viewStore.binding(get: \.currentPageIndex, send: OnboardingFeature.Action.imageCarouselChanged))
                .animation(.easeInOut, value: viewStore.currentPageIndex)
        }
    }
    
    private func titleView(_ viewStore: ViewStore<OnboardingFeature.State, OnboardingFeature.Action>) -> some View {
        VStack(spacing: 4) {
            Text(viewStore.pages[viewStore.currentPageIndex].title)
                .font(Fonts.boldTitleTextFont)
                .foregroundStyle(.customBlack)
                .multilineTextAlignment(.center)
            Text(viewStore.pages[viewStore.currentPageIndex].description)
                .font(Fonts.smallTitleTextFont)
                .foregroundStyle(.customBlack)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
    }
}
#Preview {
    OnboardingView(
        store: Store(
            initialState: OnboardingFeature.State(),
            reducer: { OnboardingFeature()}
        )
    )
}
