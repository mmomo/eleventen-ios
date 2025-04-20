//
//  UserRegisterModel.swift
//  ElevenTen
//
//  Created by Jorge Romo on 19/04/25.
//

import Foundation

struct UserRegisterModel: Decodable {
    let success: Bool
    let message: String
    let token: String?
    let user: RegisteredUser?
}

struct RegisteredUser: Decodable {
    let id: String
    let name: String
    let email: String
}
