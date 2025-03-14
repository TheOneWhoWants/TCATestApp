//
//  TitleTestAppApp.swift
//  TitleTestApp
//
//  Created by Matt on 3/12/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store: Store(
                    initialState: AppFeature.State.initial,
                    reducer: { AppFeature() }
                )
            )
        }
    }
}
