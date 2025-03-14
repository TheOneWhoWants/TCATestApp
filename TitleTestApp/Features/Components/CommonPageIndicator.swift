//
//  CommonPageIndicator.swift
//  TitleTestApp
//
//  Created by Matt on 3/13/25.
//

import SwiftUI

struct CommonPageIndicator: View {
    let numberOfPages: Int
    @Binding var currentPage: Int
    
    @Namespace private var namespace

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                ZStack {
                    Circle()
                        .fill(currentPage == index ? Color.customBlack : Color.customLightGray)
                        .frame(width: 16, height: 8)
                    
                    if currentPage == index {
                        Circle()
                            .stroke(Color.black, lineWidth: 2)
                            .frame(width: 16, height: 16)
                            .matchedGeometryEffect(id: "selectedPage", in: namespace)
                            .animation(.easeInOut, value: currentPage)
                    }
                    
                }
            }
        }
        .frame(height: 20)
    }
}

#Preview {
    CommonPageIndicator(numberOfPages: 3, currentPage: .constant(1))
}
