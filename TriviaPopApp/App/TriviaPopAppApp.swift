//
//  TriviaPopAppApp.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 23/1/26.
//

import SwiftUI
import Combine
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

@main
struct TriviaPopAppApp: App {
    
    @StateObject private var router = AppRouter()
    
    init() {
            FirebaseApp.configure()
        }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path){
                build(route: router.root)
                    .navigationDestination(for: AppRoute.self) { route in
                        build(route: route)
                    }
            }
        }
    }
    
    @ViewBuilder
    private func build(route: AppRoute ) -> some View {
        
        switch route {
        case .home:
            HomeView(viewModel: HomeViewModel( router: router))
                .task {
                    await testFirestore()
                }
            
            
        case .matchMaking:
            
            
            let repository = GameCenterMatchmakingRepository()
            let useCase = SearchOpponentUseCase(repository: repository)
            
            SearchOpponentView(
                viewModel: SearchOpponentViewModel(
                    useCase: useCase,
                    router: router
                )
            )
            
        case .portalLoading:
            Text("SplportalLoadingash")
        case .soloWheel:
            CategoryWheelView(viewModel: CategoryWheelViewModel(router: router))
            
        case .soloLoading(let category):
            PortalLoadingView(viewModel: PortalLoadingViewModel(router: router, category: category))
        case.soloQuestion(listOfQuestions: let questionPack, index: let index):
            SoloQuestionView(viewModel: SoloQuestionViewModel(router: router, listOfQuestions: questionPack, index: index))
            //  case .soloQuestion(let index):
            //    SoloQuestionView(viewModel: SoloQuestionViewModel(router: router, index: index))
            
        case .soloResults(let result):
            SoloResultsView(viewModel: SoloResultsViewModel(router: router ,result: result))
        }
        
    }
}


