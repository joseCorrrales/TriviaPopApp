//
//  LLMQuestionEngine.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 23/2/26.
//

import Foundation
import FoundationModels

@Generable
struct QuestionItem: Hashable {
    
    let id: String
    let difficulty: String
    let question: String
    let options: [String]
    let correctIndex: Int
    let explanation: String
    
}
