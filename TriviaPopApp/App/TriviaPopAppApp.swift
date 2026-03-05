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
import FirebaseDatabase


@main
struct TriviaPopAppApp: App {
    
    @StateObject private var router = AppRouter()
    
    
    init() {
        FirebaseApp.configure()
        
        Task {
            if Auth.auth().currentUser == nil {
                _ = try? await Auth.auth().signInAnonymously()
            }
        }
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
            
        case .matchMaking:
            
            let repository = FirebasePresenceRepository()
            let startPresenceUseCase = StartPresenceUseCase(repository: repository)
            let stopPresenceUseCase = StopPresenceUseCase(repository: repository)
            
            LobbyView(viewModel: LobbyViewModel(router: router,startPresenceUseCase:startPresenceUseCase ,stopPresenceUseCase: stopPresenceUseCase))
            /*   let repository = GameCenterMatchmakingRepository()
             let useCase = SearchOpponentUseCase(repository: repository)
             
             SearchOpponentView(
             viewModel: SearchOpponentViewModel(
             useCase: useCase,
             router: router
             )
             )*/
        case .portalLoading:
            Text("SplportalLoadingash")
        case .soloWheel:
            CategoryWheelView(viewModel: CategoryWheelViewModel(router: router))
        case .soloLoading(let category):
            PortalLoadingView(viewModel: PortalLoadingViewModel(router: router, category: category))
        case.soloQuestion(listOfQuestions: let questionPack, index: let index):
            SoloQuestionView(viewModel: SoloQuestionViewModel(router: router, listOfQuestions: questionPack, index: index))
        case .soloResults(let result):
            SoloResultsView(viewModel: SoloResultsViewModel(router: router ,result: result))
            
        }
    }
    
    func ensureAnonymousLogin() async {
        if Auth.auth().currentUser == nil {
            try? await Auth.auth().signInAnonymously()
        }
    }
}

