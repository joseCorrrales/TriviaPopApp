//
//  UserService.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 1/3/26.
//

import FirebaseFirestore
import FirebaseAuth


final class UserService {
    
    private let db = Firestore.firestore()
    

    
    func searchUsers(by username: String) async throws -> [User] {
        
        guard !username.isEmpty else { return [] }
        guard let currentUID = Auth.auth().currentUser?.uid else { return [] }
        
        let queryText = username.lowercased()
        
        let snapshot = try await db.collection("users")
            .whereField("username_lowercase", isGreaterThanOrEqualTo: queryText)
            .limit(to: 20)
            .getDocuments()
        
        return snapshot.documents
            .filter { $0.documentID != currentUID }
            .map { doc in
                User(
                    id: doc.documentID,
                    name: doc["username"] as? String ?? ""
                )
            }
    }
    
    
    // MARK: - Get User By ID
    
    func getUser(by id: String) async throws -> User? {
        
        let document = try await db.collection("users")
            .document(id)
            .getDocument()
        
        guard let data = document.data() else { return nil }
        
        return User(
            id: document.documentID,
            name: data["username"] as? String ?? ""
        )
    }
}
