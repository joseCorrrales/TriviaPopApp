//
//  LLMQuestionGeneratorError.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 23/2/26.
//

enum LLMQuestionGeneratorError: Error {
    case invalidModelOutput
    case decodeFailed
    case invalidQuestionPack(reason: String)
}
