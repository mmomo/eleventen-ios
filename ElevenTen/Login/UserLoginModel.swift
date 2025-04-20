//
//  UserLoginResponse.swift
//  ElevenTen
//
//  Created by Jorge Romo on 19/04/25.
//

import Foundation

struct UserLoginModel: Decodable {
    let success: Bool
    let message: String
    let token: String?
    let user: LoggedUser?
}

struct LoggedUser: Decodable {
    let id: String
    let name: String
    let email: String
}
