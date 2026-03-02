//
//  LLMQuestionEngine.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 23/2/26.
//


import Foundation
import FoundationModels




public final class LLMQuestionEngine: QuestionEngine {
    
    private let model : LanguageModelSession
    
    
    init() {
        model = .init()
    }
    
    func generate(
        category: Category,
        difficulty: Difficulty,
        count: Int
    ) async throws -> [Question] {
        
        
        let prompt = buildPrompt(category: category, count: 10, ageRange: "6-13", language: "en")
        
        let pack = try await model.respond(to: prompt, generating: [QuestionItem].self)
        return pack.content.map {
            Question(
                prompt: $0.question,
                options: $0.options,
                correctIndex: $0.correctIndex,
                category: category,
                difficulty: Difficulty(rawValue: $0.difficulty) ?? .medium
            )
        }
    }
}

private extension LLMQuestionEngine {
    
     func buildPrompt(category: Category, count: Int, ageRange: String, language: String) -> String {
        """
        You are generating a kid-safe pop culture trivia quiz.
        
        Requirements:
        - Language: \(language)
        - Age range: \(ageRange)
        - Category: \(category)
        - Generate exactly \(count) questions.
        - Difficulty mix: 6 easy, 4 medium.
        - Each question has exactly 4 options and exactly 1 correct answer.
        - Avoid ambiguity. No "best/most popular" questions.
        - Keep the question text short (<= 120 characters if possible).
        - Kid-safe only. No sexual content, self-harm, drugs, or graphic violence.
        - You may include well-known brands/characters/titles appropriate for kids.
        """
    }
}
