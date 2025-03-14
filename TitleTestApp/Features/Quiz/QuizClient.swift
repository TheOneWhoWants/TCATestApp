//
//  QuizClient.swift
//  TitleTestApp
//
//  Created by Matt on 3/13/25.
//

import Foundation
import ComposableArchitecture

struct QuizClient {
    var fetchQuestions: @Sendable () async throws -> [QuizQuestion]
    var submitAnswers: @Sendable ([Int: [Int]]) async throws -> Bool
}

extension QuizClient: DependencyKey {
    static let liveValue = QuizClient(
        fetchQuestions: {
            let mockQuestions: [QuizQuestion] = [
                .init(id: 1, theme: "Lifestyle & Interests", title: "What’d you like our stylists to focus on?", description: "We offer services via live-chat mode.", answers: [
                    .init(id: 1, title: "Reinvent wardrobe", description: "to discover fresh outfit ideas"),
                    .init(id: 2, title: "Define color palette", description: "to enhance my natural features"),
                    .init(id: 3, title: "Create a seasonal capsule", description: "to curate effortless and elegant looks"),
                    .init(id: 4, title: "Define my style", description: "to discover my signature look"),
                    .init(id: 5, title: "Create an outfit for an event", description: "to own a spotlight wherever you go")
                ]),
                .init(id: 2, theme: "Style preferences", title: "Which style best represents you?", answers: [
                    .init(id: 1, title: "Casual", imageURL: "model1"),
                    .init(id: 2, title: "Boho", imageURL: "model2"),
                    .init(id: 3, title: "Classy", imageURL: "model3"),
                    .init(id: 4, title: "Ladylike", imageURL: "model2"),
                    .init(id: 5, title: "Urban", imageURL: "model5"),
                    .init(id: 6, title: "Sporty", imageURL: "model6"),
                    .init(id: 7, title: "Sporty", imageURL: "model7"),
                    .init(id: 8, title: "Sporty", imageURL: "model8")
                ]),
                .init(id: 3, theme: "Style preferences", title: "Choose favourite colors", answers: [
                    .init(id: 1, title: "Light blue", colorHex: "#ABE2FF"),
                    .init(id: 2, title: "Blue", colorHex: "#5EA8FF"),
                    .init(id: 3, title: "Indigo", colorHex: "#2237A8"),
                    .init(id: 4, title: "Turquoise", colorHex: "#69D1ED"),
                    .init(id: 5, title: "Mint", colorHex: "#87DBC8"),
                    .init(id: 6, title: "Olive", colorHex: "#A8AD49"),
                    .init(id: 7, title: "Green", colorHex: "#29AD3E"),
                    .init(id: 8, title: "Emerald", colorHex: "#098052"),
                    .init(id: 9, title: "Beige", colorHex: "#EDDD47"),
                    .init(id: 10, title: "Orange", colorHex: "#CD6A09"),
                    .init(id: 11, title: "Brown", colorHex: "#7F4B03"),
                    .init(id: 12, title: "Pink", colorHex: "#FF86B8"),
                    .init(id: 13, title: "Magenta", colorHex: "#CF236E"),
                    .init(id: 14, title: "Red", colorHex: "#D31E1E")
                ])
            ]
            return mockQuestions
        },
        submitAnswers: { selections in
            try await Task.sleep(nanoseconds: 100000)
            return true
        }
    )
}

extension DependencyValues {
    var quizClient: QuizClient {
        get { self[QuizClient.self] }
        set { self[QuizClient.self] = newValue }
    }
}
