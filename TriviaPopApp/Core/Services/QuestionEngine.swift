//
//  QuestionEngine.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 23/2/26.
//

import Foundation

protocol QuestionEngine {
    func generate(
        category: Category,
        difficulty: Difficulty,
        count: Int
    ) async throws -> [Question]
}
