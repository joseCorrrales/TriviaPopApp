//
//  PresenceRepository.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 4/3/26.
//

protocol PresenceRepository {
    func start(displayName: String?) async throws
    func stop()
    
}
