//
//  AnswerCell.swift
//  TitleTestApp
//
//  Created by Matt on 3/13/25.
//

import ComposableArchitecture
import SwiftUI

struct AnswerCell: View {
    let answer: QuizAnswer
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .center) {
                if answer.description == nil {
                    Spacer()
                }
                
                VStack(alignment: answer.description == nil ? .center : .leading, spacing: 0) {
                    if let image = answer.imageURL {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 108, height: 122)
                    }
                    if let color = answer.colorHex {
                        Rectangle()
                            .fill(Color(hex: color))
                            .frame(width: 32, height: 32)
                    }
                    Text(answer.title.uppercased())
                        .font(isSelected ? Fonts.smallQuizFont : Fonts.smallQuizButtonFont)
                        .foregroundStyle(.quizBlack)
                        .frame(height: 20)
                        .fixedSize(horizontal: true, vertical: true)
                    if let description = answer.description {
                        Text(description)
                            .font(Fonts.smallQuizButtonFont)
                            .foregroundStyle(.quizBlack)
                    }
                }
                .padding(10)
                Spacer()
            }
            .overlay {
                ZStack {
                    Rectangle()
                        .stroke(isSelected ? .quizBlack : .quizGray, lineWidth: 1)
                        .frame(minHeight: 72, maxHeight: 162)
                        .frame(minWidth: 108)
                    HStack {
                        Spacer()
                        VStack {
                            Rectangle()
                                .stroke(isSelected ? .quizBlack : .quizGray, lineWidth: 2)
                                .background(isSelected ? .quizBlack : .clear)
                                .frame(width: 20, height: 20)
                                .overlay {
                                    if isSelected {
                                        Image("selectedCheckboxImage")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 14, height: 14)
                                    }
                                }
                            if answer.description == nil {
                                Spacer()
                            }
                        }
                    }
                    .padding(5)
                }
            }
        }
        .padding(10)
    }
}
