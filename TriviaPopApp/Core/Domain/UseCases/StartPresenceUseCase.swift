//
//  StartPresenceUseCase.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 4/3/26.
//

final class StartPresenceUseCase{
    
    private let repository: PresenceRepository
    
    init(repository: PresenceRepository) {
        self.repository = repository
    }
    
    func execute(displayName: String) async throws {
        try await repository.start(displayName: displayName)
    }
}
