//
//  HomeViewModel.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 23/1/26.
//

import Foundation
import Combine

@MainActor
final class SoloQuestionViewModel: ObservableObject {
    
    private let router : AppRouter
    let listOfQuestions: [Question]

    @Published private(set) var index: Int = 1
    @Published private(set) var correct = 0
    @Published private(set) var incorrect = 0
    
    init(router: AppRouter, listOfQuestions: [Question], index: Int, correct: Int = 0, incorrect: Int = 0) {
        self.router = router
        self.listOfQuestions = listOfQuestions
        self.index = index
        self.correct = correct
        self.incorrect = incorrect
    }
    
    var question: Question {
        listOfQuestions[index - 1] 
    }
    
    func startTrivia() {
        router.push(.matchMaking)
    }
    
    func startVersus() {
        router.push(.matchMaking)
    }
    
    func answer(selectedIndex: Int) {
        let isCorrect = (selectedIndex == question.correctIndex)
        if isCorrect {
            correct += 1
        }
        else {
            incorrect += 1
        }
        checkRouter()
    }
    
    func checkRouter() {
        if index >= 10 {
            router.push(.soloResults(result: .init(correct: correct, incorrect: incorrect)))
        } else {
          index += 1
           
        }
    }
}
