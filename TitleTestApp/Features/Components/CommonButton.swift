//
//  CommonButton.swift
//  TitleTestApp
//
//  Created by Matt on 3/13/25.
//

import SwiftUI

struct CommonButton: View {
    let title: String
    let isBlackButton: Bool
    let isSmallButton: Bool
    let onAction: () -> ()
    
    init(title: String, isBlackButton: Bool = true, isSmallButon: Bool = false, onAction: @escaping () -> Void) {
        self.title = title
        self.isBlackButton = isBlackButton
        self.isSmallButton = isSmallButon
        self.onAction = onAction
    }
    
    var body: some View {
        Button {
            onAction()
        } label: {
            Rectangle()
                .fill(isBlackButton ? .customBlack: .white)
                .frame(height: isSmallButton ? 48 : 60)
                .overlay {
                    Text(title)
                        .font(isSmallButton ? Fonts.smallButtonTextFont : Fonts.buttonTextFont)
                        .foregroundStyle(isBlackButton ? .white : .customBlack)
                }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    CommonButton(title: "CONTINUE", isBlackButton: false, onAction: {})
}
