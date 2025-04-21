//
//  ProgramModel.swift
//  ElevenTen
//
//  Created by Jorge Romo on 01/05/24.
//

import Foundation

struct Program: Codable {
    let id: String
    let programName: String
    let duration: String
    let level: String
    let days: [Day]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case programName
        case duration
        case level
        case days
    }
}

struct Day: Identifiable, Codable, Hashable, Equatable {
    let id: String
    let dayName: String
    let drills: [Drill]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case dayName
        case drills
    }

    static func == (lhs: Day, rhs: Day) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Drill: Identifiable, Codable, Hashable, Equatable {
    let id: String
    let type: String
    let title: String
    let description: String?
    let imageUrl: String?
    let videoUrl: String?
    let videos: [Video]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case type
        case title
        case description
        case imageUrl
        case videoUrl
        case videos
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Drill, rhs: Drill) -> Bool {
        lhs.id == rhs.id
    }
}


struct Video: Codable {
    let title: String
    let videoUrl: String
}
