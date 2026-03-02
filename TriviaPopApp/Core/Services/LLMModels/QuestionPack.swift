//
//  QuestionPack.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 23/2/26.
//

import Foundation

public struct QuestionPack: Hashable {
    let category: String
    let ageRange: String
    let language: String
    let questions: [QuestionItem]
}
