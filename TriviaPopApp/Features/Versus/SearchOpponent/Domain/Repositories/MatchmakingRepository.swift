//
//  MatchmakingRepository.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 7/2/26.
//

protocol MatchmakingRepository {
    func authenticate() async throws
    func searchOpponent() async throws -> Player
    func cancelSearch()
}
