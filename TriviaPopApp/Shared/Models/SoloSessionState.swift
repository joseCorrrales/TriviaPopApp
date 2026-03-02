//
//  SoloSessionState.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 28/1/26.
//

import Foundation

struct SoloSessionState: Hashable, Codable {
    var categoryId: String
    var currentIndex: Int
    var correct: Int
    var incorrect: Int
}
