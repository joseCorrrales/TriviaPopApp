final class SearchOpponentUseCase {

    private let repository: MatchmakingRepository

    init(repository: MatchmakingRepository) {
        self.repository = repository
    }

    func execute() async throws -> Player {
        try await repository.authenticate()
        return try await repository.searchOpponent()
    }

    func cancel() {
        repository.cancelSearch()
    }
}
