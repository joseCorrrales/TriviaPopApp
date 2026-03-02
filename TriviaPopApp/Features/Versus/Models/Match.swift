//
//  Match.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 1/3/26.
//

import Foundation


enum MatchStatus: String, Codable {
    case pending
    case active
    case finished
}

struct Match: Codable, Equatable {
    var id: String
    var players1 : String
    var players2 : String
    
    var status: MatchStatus
    var createdAt: Date
    
}
