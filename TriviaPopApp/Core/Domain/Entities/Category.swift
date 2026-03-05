//
//  Untitled.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 28/1/26.
//

import Foundation


public struct Category: Hashable,Identifiable, Codable {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
