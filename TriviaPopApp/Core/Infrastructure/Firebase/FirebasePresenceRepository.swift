//
//  FirebasePresenceRepository.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 2/3/26.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

struct FirebasePresencePayload {
    let uid: String
    let name: String?
    let state: String
    
    var asDict: [String: Any] {
        var dict: [String: Any] = [
            "uid": uid,
            "state": state,
            "last_changed": ServerValue.timestamp()
        ]
        if let name { dict["name"] = name }
        return dict
    }
}

enum PresenceState {
    case idle
    case online
    case offline
    case error(Error)
}

enum PresenceError: Error {
    case userNotAuthenticated
}

final class FirebasePresenceRepository: PresenceRepository {
    
    private let auth: Auth
    private let database: DatabaseReference
    
    private var continuation: AsyncStream<PresenceState>.Continuation?
    
    lazy var stateStream: AsyncStream<PresenceState> = {
        AsyncStream { continuation in
            self.continuation = continuation
        }
    }()
    
    private var connectedHandle: DatabaseHandle?
    
    init(
        auth: Auth = Auth.auth(),
        database: DatabaseReference = Database.database().reference()
    ) {
        self.auth = auth
        self.database = database
    }
    
    func start(displayName: String?) async throws {
        guard let uid = auth.currentUser?.uid else {
            continuation?.yield(.error(PresenceError.userNotAuthenticated))
            throw PresenceError.userNotAuthenticated
        }
        
        let userStatusRef = database.child("status").child(uid)
        let connectedRef = database.child(".info/connected")
        
        connectedHandle = connectedRef.observe(.value) { [weak self] snapshot in
            guard let self else { return }
            guard let connected = snapshot.value as? Bool else { return }
            if connected {
                continuation?.yield(.online)
            } else {
                continuation?.yield(.offline)
            }
            let online = FirebasePresencePayload(uid: uid, name: displayName, state: "online").asDict
            let offline = FirebasePresencePayload(uid: uid, name: displayName, state: "offline").asDict
            
            userStatusRef.onDisconnectSetValue(offline)
            userStatusRef.setValue(online)
        }
    }
    
    func stop() {
        continuation?.yield(.offline)
    }
}

