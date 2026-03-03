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
}

final class UserService {
    
    private let db = Database.database().reference()
    
  
    func listenToOnlineUsers(
           onChange: @escaping ([OnlineUser]) -> Void
       ) -> DatabaseHandle {
           
           let statusRef = db.child("status")
           
           let handle = statusRef.observe(.value) { snapshot in
               
               var onlineUsers: [OnlineUser] = []
               
               for child in snapshot.children {
                   if let snap = child as? DataSnapshot,
                      let value = snap.value as? [String: Any],
                      let state = value["state"] as? String,
                      state == "online" {
                       
                       onlineUsers.append(
                        OnlineUser(id: value["User"] as! String)
                       )
                   }
               }
               
               onChange(onlineUsers)
           }
           
           return handle
       }
       
       func stopListening(handle: DatabaseHandle) {
           db.child("status").removeObserver(withHandle: handle)
       }
    
  
   
}
