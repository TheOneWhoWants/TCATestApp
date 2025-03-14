//
//  Transitions.swift
//  TitleTestApp
//
//  Created by Matt on 3/13/25.
//

import SwiftUI

extension AnyTransition {
    static var slide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading)
        )
    }

    static var fade: AnyTransition {
        AnyTransition.opacity
    }
}
