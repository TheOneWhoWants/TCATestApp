//
//  IntroView.swift
//  TitleTestApp
//
//  Created by Matt on 3/12/25.
//

import SwiftUI
import ComposableArchitecture

struct IntroView: View {
    let store: StoreOf<IntroFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                background
                overlayGradient
                
                VStack(alignment: .leading) {
                    Spacer()
                    introText
                    CommonButton(title: "CONTINUE", isBlackButton: false, isSmallButon: true) {
                        viewStore.send(.navigateToOnboarding)
                    }
                    .padding(.vertical, 20)
                }
                .safeAreaPadding(.bottom)
            }
        }
    }
    
    private var background: some View {
        Image("introBackgroundImage")
            .resizable()
            .ignoresSafeArea()
            .scaledToFill()
    }
    
    private var overlayGradient: some View {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: .black.opacity(0), location: 0.3),
                .init(color: .black, location: 0.85)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
    
    private var introText: some View {
        Text("Online Personal Styling. Outfits for Every Woman.".replacingOccurrences(of: ". ", with: ".\n"))
            .foregroundStyle(.white)
            .font(Fonts.largeTitleTextFont)
            .multilineTextAlignment(.leading)
            .padding(.horizontal, 20)
    }
}

#Preview {
    IntroView(
        store: Store(
            initialState: IntroFeature.State(),
            reducer: { IntroFeature() }
        )
    )
}
