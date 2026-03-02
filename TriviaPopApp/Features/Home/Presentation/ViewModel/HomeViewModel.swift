//
//  HomeViewModel.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 23/1/26.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    
    private let router : AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func startTrivia() {
        router.push(.soloWheel)
    }
    
    func startVersus() {
        router.push(.matchMaking)
    }
}
