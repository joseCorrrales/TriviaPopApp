//
//  StopPresenceUseCase.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 4/3/26.
//

final class StopPresenceUseCase{
    
    private let repository: PresenceRepository
    
    init(repository: PresenceRepository) {
        self.repository = repository
    }
    func execute()  {
        repository.stop()
    }
}
