//
//  AppRoute.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 23/1/26.
//

import Foundation

enum AppRoute: Hashable {
    
    case home
    case matchMaking
    case portalLoading
    case soloWheel
    case soloLoading(category: Category)
    case soloQuestion(listOfQuestions: [Question], index: Int)
    case soloResults(result: GameResult)
 
    
}

