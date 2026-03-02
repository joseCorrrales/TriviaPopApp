import Foundation
import Combine

enum MatchSearchState: Equatable {
    case idle
    case authenticating
    case searching
    case matched(Player)
    case failed(String)
}


@MainActor
final class SearchOpponentViewModel: ObservableObject {

    @Published private(set) var state: MatchSearchState = .idle

    private let useCase: SearchOpponentUseCase
    private let router: AppRouter

    init(useCase: SearchOpponentUseCase, router: AppRouter) {
        self.useCase = useCase
        self.router = router
    }

    func startSearch() {
        state = .authenticating

        Task {
            do {
                state = .searching
                let opponent = try await useCase.execute()
                state = .matched(opponent)
            } catch {
                state = .failed(error.localizedDescription)
            }
        }
    }

    func cancelSearch() {
        useCase.cancel()
        state = .idle
    }
}
