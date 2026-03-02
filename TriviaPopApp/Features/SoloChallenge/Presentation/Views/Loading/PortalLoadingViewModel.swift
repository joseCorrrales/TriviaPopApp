//
//  PortalLoadingViewModel.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 28/1/26.
//

import Foundation
import Combine


@MainActor
final class PortalLoadingViewModel: ObservableObject {
  
    private let router: AppRouter
    private let category: Category
    private let llm: LLMQuestionEngine
    
    @Published var errorMessage: String?

    init(router: AppRouter, category: Category, llm: LLMQuestionEngine = .init()) {
        self.router = router
        self.category = category
        self.llm = llm
    }

    func start() async {
       
        errorMessage = nil
        
        do {
            let listOfQuestions = try await llm.generate(category: category.self, difficulty: Difficulty.easy, count: 10)
            
            router.push(.soloQuestion(listOfQuestions: listOfQuestions, index: 1))
            
        } catch {
            errorMessage = "Error generating questions. Please try again later."
        }
        
    }
}
