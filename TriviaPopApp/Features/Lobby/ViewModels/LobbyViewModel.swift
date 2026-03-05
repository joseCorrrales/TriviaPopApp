//
//  LobbyViewModel.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 2/3/26.
//

import Foundation
import FirebaseDatabase
import Combine

@MainActor
final class LobbyViewModel: ObservableObject {
    
    @Published var onlineUsers: [OnlineUser] = []
    
    private let router: AppRouter
    private let userService = UserService()
    private var handle: DatabaseHandle?
    
    private let startPresenceUseCase: StartPresenceUseCase
    private let stopPresenceUseCase: StopPresenceUseCase
    
    init(router: AppRouter, startPresenceUseCase: StartPresenceUseCase,
         stopPresenceUseCase: StopPresenceUseCase) {
        
        self.router = router
        self.startPresenceUseCase = startPresenceUseCase
        self.stopPresenceUseCase = stopPresenceUseCase
    }
    
    func startListening() async {
        Task {
            try? await startPresenceUseCase.execute(displayName: "Player 1")
        }
        
        guard handle == nil else { return }
        handle = userService.listenToOnlineUsers { [weak self] users in
            self?.onlineUsers = users
        }
    }
    
/*    func onAppear() {
        Task {
            try? await startPresenceUseCase.execute(displayName: "Player 1")
        }
    }
    */
    func onDisappear() {
        stopPresenceUseCase.execute()
    }
    
    
}
