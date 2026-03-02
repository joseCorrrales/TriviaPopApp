//
//  AppRouter.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 23/1/26.
//
import Foundation
import Combine


@MainActor
final class AppRouter: ObservableObject {

    @Published var path: [AppRoute] = []
    @Published var root: AppRoute = .home
    
    func push(_ route: AppRoute) {
        path.append(route)
    }
    
    func pop() -> AppRoute? {
        return path.popLast()
    }
    
    func reset(to route: AppRoute) {
        path.removeAll()
        root = route
    }

}

