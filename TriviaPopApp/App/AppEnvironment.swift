//
//  AppEnvironment.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 23/1/26.
//

import Foundation
import Combine

@MainActor
final class AppEnvironment {
    let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
}
