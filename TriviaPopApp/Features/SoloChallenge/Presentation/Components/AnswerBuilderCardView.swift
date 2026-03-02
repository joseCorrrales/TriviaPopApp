//
//  AnswerBuilderCardView.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 28/1/26.
//

import SwiftUI

struct AnswerBuilderCardView: View {
    let viewModel: SoloQuestionViewModel
    let question: Question
    
    @State private var hasAnswered: Bool = false
    @State private var selectedIndex: Int? = nil
    
    var body: some View {
        VStack(spacing: 24) {
            
            ForEach(Array(question.options.enumerated()), id: \.offset) { index, option in
                AnswerButton(text:option ,
                             height: 90,
                             width:350,
                             isCorrect: index == question.correctIndex,
                             hasAnswered: hasAnswered ) {
                    
                    guard !hasAnswered else { return }
                    withAnimation(.easeInOut) {
                        selectedIndex = index
                        hasAnswered = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        hasAnswered = false
                        selectedIndex = nil
                        viewModel.answer(selectedIndex: index)
                        }
                }
            }
        }
    }
}


#Preview("Home") {
    
    let questionPack =    [Question(id: UUID(), prompt: "", options: ["A","B","C","D"], correctIndex: 1, category: Category(id: 1, name: "CINE"), difficulty: Difficulty.easy)]
    
    let vm =  SoloQuestionViewModel(router: AppRouter(), listOfQuestions:  questionPack, index: 1, correct: 0, incorrect: 0)
    AnswerBuilderCardView(viewModel: vm, question: questionPack[0])
    
}
