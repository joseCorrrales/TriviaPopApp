//
//  testFirestore.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 1/3/26.
//

import FirebaseAuth
import FirebaseFirestore

func testFirestore() async {
    do {
        // Autenticación anónima
        if Auth.auth().currentUser == nil {
            try await Auth.auth().signInAnonymously()
        }
        
        guard let uid = Auth.auth().currentUser?.uid else {
            print("No UID")
            return
        }
        
        let db = Firestore.firestore()
        
        try await db.collection("queue")
            .document(uid)
            .setData([
                "timestamp": FieldValue.serverTimestamp(),
                "message": "Connection OK"
            ])
        
        print("✅ FIRESTORE WORKING")
        
    } catch {
        print("❌ FIRESTORE ERROR:", error.localizedDescription)
    }
}
