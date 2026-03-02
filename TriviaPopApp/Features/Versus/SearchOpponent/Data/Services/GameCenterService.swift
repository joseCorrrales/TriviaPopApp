//
//  GameCenterService.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 7/2/26.
//
import GameKit
import Foundation

final class GameCenterService {

    func authenticate() async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            GKLocalPlayer.local.authenticateHandler = { viewController, error in

                if let error {
                    continuation.resume(throwing: error)
                    return
                }

                if let viewController {
                    Task { @MainActor in
                        UIApplication.shared
                            .rootController?
                            .present(viewController, animated: true)
                    }
                    return
                }
                if GKLocalPlayer.local.isAuthenticated {
                    continuation.resume()
                }
            }
        }
    }
    
    
    func authenticateLocalPlayer(presentingVC: UIViewController) {
        let localPlayer = GKLocalPlayer.local
        
        localPlayer.authenticateHandler = { viewController, error in
            if let vc = viewController {
                presentingVC.present(vc, animated: true, completion: nil)
            } else if localPlayer.isAuthenticated {
                print("Jugador autenticado: \(localPlayer.displayName)")
           
            } else {
                print("Error de autenticación: \(String(describing: error?.localizedDescription))")
            }
        }}
    

    func findMatch() async throws -> GKMatch {
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2

        return try await withCheckedThrowingContinuation { continuation in
            GKMatchmaker.shared().findMatch(for: request) { match, error in
                if let error {
                    continuation.resume(throwing: error)
                } else if let match {
                    continuation.resume(returning: match)
                }
            }
        }
    }
}

extension UIApplication {
    var rootController: UIViewController? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .rootViewController
    }
}
