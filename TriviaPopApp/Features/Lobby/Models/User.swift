//
//  User.swift
//  TriviaPopApp
//
//  Created by Jose Corrales on 1/3/26.
//
struct User: Identifiable, Codable {
    var id: String?
    let name: String
    let isOnline: Bool?
}
