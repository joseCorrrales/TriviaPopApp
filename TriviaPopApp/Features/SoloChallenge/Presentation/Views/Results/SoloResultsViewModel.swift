//
//  PortalLoadingViewModel.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 28/1/26.
//

import Foundation
import Combine


@MainActor
final class SoloResultsViewModel: ObservableObject {
    private let router: AppRouter
     let result: GameResult

    init(router: AppRouter , result: GameResult) {
        self.router = router
        self.result = result
    }

    func start() async {
        router.reset(to: .home)
    }
}
