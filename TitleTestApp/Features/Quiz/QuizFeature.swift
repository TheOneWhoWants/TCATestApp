//
//  QuizFeature.swift
//  TitleTestApp
//
//  Created by Matt on 3/13/25.
//

import ComposableArchitecture
import SwiftUI

struct QuizFeature: Reducer {
    @Dependency(\.quizClient) var quizClient

    struct State: Equatable {
        var questions: [QuizQuestion] = []
        var currentQuestionIndex: Int = 0
        var selections: [Int: [Int]] = [:]
        var isQuizCompleted: Bool = false
        var isLoading: Bool = true
        var error: String? = nil
    }

    enum Action: Equatable {
        case loadQuestions
        case questionsLoaded([QuizQuestion])
        case loadFailed(String)
        case selectAnswer(questionId: Int, answerId: Int)
        case goToNextQuestion
        case goToPreviousQuestion
        case submitAnswers
        case answersSubmitted(Bool)
        case finishQuiz
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .loadQuestions:
                state.isLoading = true
                return .run { send in
                    do {
                        let questions = try await quizClient.fetchQuestions()
                        await send(.questionsLoaded(questions))
                    } catch {
                        await send(.loadFailed(error.localizedDescription))
                    }
                }
            case let .questionsLoaded(questions):
                state.isLoading = false
                state.questions = questions
                return .none

            case let .loadFailed(error):
                state.isLoading = false
                state.error = error
                return .none

            case let .selectAnswer(questionId, answerId):
                var chosenOptions = state.selections[questionId] ?? []
                if chosenOptions.contains(answerId) {
                    chosenOptions.removeAll { $0 == answerId }
                    state.selections[questionId] = chosenOptions
                } else {
                    chosenOptions.append(answerId)
                    state.selections[questionId] = chosenOptions
                }
                return .none
            case .goToNextQuestion:
                guard state.currentQuestionIndex < state.questions.count - 1 else {
                    return .send(.submitAnswers)
                }
                
                let questionId = state.questions[state.currentQuestionIndex].id
                if let selectedAnswers = state.selections[questionId], !selectedAnswers.isEmpty {
                    state.currentQuestionIndex += 1
                }
                
                return .none

                
//                if state.currentQuestionIndex < state.questions.count - 1 {
//                    if !(state.selections[state.currentQuestionIndex]?.isEmpty ?? false) {
//                        state.currentQuestionIndex += 1
//                    }
//                } else {
//                    return .send(.submitAnswers)
//                }
//                return .none

            case .goToPreviousQuestion:
                if state.currentQuestionIndex != 0 {
                    state.currentQuestionIndex -= 1
                }
                return .none
            case .submitAnswers:
                state.isLoading = true
                return .run { [selections = state.selections] send in
                    do {
                        let success = try await quizClient.submitAnswers(selections)
                        await send(.answersSubmitted(success))
                    }
                }
            case .answersSubmitted(let success):
                state.isLoading = false
                return .send(.finishQuiz)
            case .finishQuiz:
                state.isQuizCompleted = true
                return .none
            }
        }
    }
}
