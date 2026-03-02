//
//  CategoryWheelViewModel.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 28/1/26.
//

import Foundation
import Combine

@MainActor
final class CategoryWheelViewModel: ObservableObject {
    private let router: AppRouter

    init(router: AppRouter) {
        self.router = router
    }

    func pickCategory(_ category: Category) {
        router.push(.soloLoading(category: category))
    }
}
