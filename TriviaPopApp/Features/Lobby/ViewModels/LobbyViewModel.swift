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

    init(router: AppRouter) {
        self.router = router
    }

    func startListening() {
        guard handle == nil else { return }
        PresenceService.shared.startPresence()
        handle = userService.listenToOnlineUsers { [weak self] users in
            self?.onlineUsers = users
        }
    }
    
    func stopListening() {
        PresenceService.shared.stopPresence()
        
        if let handle = handle {
            userService.stopListening(handle: handle)
        }
    }
    
  
}
