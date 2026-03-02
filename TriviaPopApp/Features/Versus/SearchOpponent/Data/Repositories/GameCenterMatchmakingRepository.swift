//
//  GameCenterMatchmakingRepository.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 7/2/26.
//

import GameKit


final class GameCenterMatchmakingRepository: MatchmakingRepository {
   
    private let service = GameCenterService()
    private var match: GKMatch?
    
    
    func searchOpponent() async throws -> Player {
            let match = try await service.findMatch()
            self.match = match

            guard let opponent = match.players.first else {
                throw NSError(
                    domain: "Matchmaking",
                    code: 0,
                    userInfo: [NSLocalizedDescriptionKey: "No opponent found"]
                )
            }

            return Player(
                id: opponent.teamPlayerID,
                name: opponent.displayName
            )
        }
    

    func authenticate() async throws {
            try await service.authenticate()
    }

    func cancelSearch() {
        
    }
}
