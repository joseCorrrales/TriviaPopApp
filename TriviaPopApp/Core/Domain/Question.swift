//
//  Question.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 23/2/26.
//

import Foundation

public struct Question: Identifiable, Codable, Hashable {

    public let id: UUID
    public let prompt: String
    public let options: [String]
    public let correctIndex: Int
    public let category: Category
    public let difficulty: Difficulty
    
    public init(
        id: UUID = UUID(),
        prompt: String,
        options: [String],
        correctIndex: Int,
        category: Category,
        difficulty: Difficulty
    ) {
        self.id = id
        self.prompt = prompt
        self.options = options
        self.correctIndex = correctIndex
        self.category = category
        self.difficulty = difficulty
    }
}

extension Question {
    
    init(from item: QuestionItem, category: Category) {
        self.id = UUID()
        self.prompt = item.question
        self.options = item.options
        self.correctIndex = item.correctIndex
        self.category = category
        self.difficulty = Difficulty(rawValue: item.difficulty) ?? .medium
    }
}
