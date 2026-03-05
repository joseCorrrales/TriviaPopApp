//
//  UserService.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 1/3/26.
//

import Foundation
import FirebaseDatabase


struct OnlineUser: Identifiable {
    let id: String
    let name: String
}

final class UserService {
    
    private let db = Database.database().reference()
    
       func stopListening(handle: DatabaseHandle) {
           db.child("status").removeObserver(withHandle: handle)
       }
    
    
    func listenToOnlineUsers(onChange: @escaping ([OnlineUser]) -> Void) -> DatabaseHandle {
        let statusRef = db.child("status")
        return statusRef.observe(.value) { snapshot in
            var online: [OnlineUser] = []
            for child in snapshot.children {
                guard
                    let snap = child as? DataSnapshot,
                    let value = snap.value as? [String: Any],
                    let state = value["state"] as? String,
                    state == "online",
                    let uid = snap.key as String?
                else { continue }
                let name = value["name"] as! String
                online.append(OnlineUser(id: uid, name: name))
            }
            onChange(online)
        }
    }
  
   
}
