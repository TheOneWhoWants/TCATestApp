//
//  View+.swift
//  TitleTestApp
//
//  Created by Matt on 3/13/25.
//

import SwiftUI

extension View {
    func safeAreaPadding(_ edge: Edge.Set) -> some View {
        let safeArea = UIApplication.shared.windows.first?.safeAreaInsets ?? .zero
        
        let padding: CGFloat
        switch edge {
        case .top:
            padding = safeArea.top
        case .bottom:
            padding = safeArea.bottom
        case .leading:
            padding = safeArea.left
        case .trailing:
            padding = safeArea.right
        default:
            padding = 0
        }
        
        return self.padding(edge, padding)
    }
}
