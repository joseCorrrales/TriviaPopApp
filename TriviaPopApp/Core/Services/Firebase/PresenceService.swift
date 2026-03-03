//
//  PresenceService.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 2/3/26.
//


extension UIDevice {
    static var hardwareIdentifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}

import Foundation
import FirebaseAuth
import FirebaseDatabase
import UIKit

final class PresenceService {
    
    static let shared = PresenceService()
    
    private init() {
        
    }
    private let db = Database.database().reference()
    
    func startPresence() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userStatusRef = db.child("status").child(uid)
        let connectedRef = db.child(".info/connected")
        
        connectedRef.observe(.value) { snapshot in
            
            guard let connected = snapshot.value as? Bool, connected else {
                return
            }
            let onlineStatus: [String: Any] = [
                "User": "\(UIDevice.hardwareIdentifier)",
                "state": "online",
                "last_changed": ServerValue.timestamp()
            ]
            let offlineStatus: [String: Any] = [
                "User": "\(UIDevice.hardwareIdentifier)",
                "state": "offline",
                "last_changed": ServerValue.timestamp()
            ]
            userStatusRef.onDisconnectSetValue(offlineStatus)
            userStatusRef.setValue(onlineStatus)
        }
    }
    
    func stopPresence() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userStatusRef = db.child("status").child(uid)
        let offlineStatus: [String: Any] = [
            "state": "offline",
            "last_changed": ServerValue.timestamp()
        ]
        userStatusRef.setValue(offlineStatus)
    }
}
