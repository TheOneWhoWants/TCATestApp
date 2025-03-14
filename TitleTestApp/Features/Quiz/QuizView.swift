//
//  QuizView.swift
//  TitleTestApp
//
//  Created by Matt on 3/13/25.
//

import SwiftUI
import ComposableArchitecture

struct QuizView: View {
    let store: StoreOf<QuizFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 24) {
                if viewStore.isLoading {
                    ProgressView("Loading questions...")
                } else if let error = viewStore.error {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    let currentQuestion = viewStore.questions[viewStore.currentQuestionIndex]
                    navigationBar(currentQuestion, viewStore)
                    
                    viewTitle(currentQuestion)
                    
                    adaptiveScrollView(currentQuestion, viewStore)
                    
                    Spacer()
                    
                    CommonButton(title: "CONTINUE", isSmallButon: true) {
                        viewStore.send(.goToNextQuestion)
                    }
                }
            }
            .padding()
            .onAppear {
                viewStore.send(.loadQuestions)
            }
        }
    }
    
    @ViewBuilder
    private func adaptiveScrollView(_ currentQuestion: QuizQuestion, _ viewStore: ViewStore<QuizFeature.State, QuizFeature.Action>) -> some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: getColumnCount(currentQuestion.answers.first))
        
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(currentQuestion.answers) { answer in
                    AnswerCell(
                        answer: answer,
                        isSelected: isSelected(viewStore, currentQuestion.id, answer.id),
                        action: {
                            viewStore.send(.selectAnswer(
                                questionId: currentQuestion.id,
                                answerId: answer.id
                            ))
                        }
                    )
                }
            }
        }
    }
    
    
    private func viewTitle(_ currentQuestion: QuizQuestion) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(currentQuestion.title)
                    .font(Fonts.quizTitleTextFont)
                    .foregroundStyle(.quizBlack)
                    .multilineTextAlignment(.leading)
                if let description = currentQuestion.description {
                    Text(description)
                        .font(Fonts.smallQuizDescriptionFont)
                        .foregroundStyle(.quizBlack)
                }
            }
            Spacer()
        }
        .padding(.leading, 10)
    }
    
    private func navigationBar(_ currentQuestion: QuizQuestion, _ viewStore: ViewStore<QuizFeature.State, QuizFeature.Action>) -> some View {
        ZStack {
            Text(currentQuestion.theme.uppercased())
                .font(Fonts.smallButtonTextFont)
                .foregroundStyle(.quizBlack)
                .multilineTextAlignment(.leading)
            HStack {
                Button {
                    viewStore.send(.goToPreviousQuestion)
                } label: {
                    Image("backButtonImage")
                        .padding(.leading, 5)
                        .opacity(currentQuestion.id > 1 ? 1 : 0)
                }
                Spacer()
            }
        }
    }
    
    private func getColumnCount(_ quizAnswer: QuizAnswer?) -> Int {
        guard let quizAnswer = quizAnswer else { return 0 }
        if quizAnswer.imageURL != nil { return 2 }
        if quizAnswer.colorHex != nil { return 3 }
        return 1
        
    }
    
    private func isSelected(_ viewStore: ViewStore<QuizFeature.State, QuizFeature.Action>, _ questionId: Int,_ answerId: Int) -> Bool {
        viewStore.selections[questionId]?.contains(answerId) == true
    }
}

#Preview("Completed Quiz") {
    QuizView(
        store: Store(
            initialState: QuizFeature.State(
                questions: [
                    QuizQuestion(
                        id: 1,
                        theme: "",
                        title: "What is your favorite color?",
                        answers: [
                            QuizAnswer(id: 1, title: "Red", imageURL: "https://example.com/red.png"),
                            QuizAnswer(id: 2, title: "Blue", imageURL: "https://example.com/blue.png")
                        ]
                    )
                ],
                currentQuestionIndex: 0,
                selections: [1: [1]],
                isQuizCompleted: true,
                isLoading: false,
                error: nil
            ),
            reducer: { QuizFeature() }
        )
    )
}
