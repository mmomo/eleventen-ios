//
//  ProgramModel.swift
//  ElevenTen
//
//  Created by Jorge Romo on 01/05/24.
//

import Foundation

struct Program: Codable {
    let programName: String
    let duration: String
    let level: String
    let days: [Day]
}

struct Day: Identifiable, Codable, Hashable, Equatable {
    var id: String
    let dayName: String
    let drills: [Drill]
    static func == (lhs: Day, rhs: Day) -> Bool {
          return lhs.id == rhs.id
      }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Drill: Identifiable, Codable, Hashable, Equatable {
    var id: String
    let type: String
    let title: String
    let description: String
    let imageUrl: String?
    let videoUrl: String?
    let videos: [Video]?
    
    // Conformidad a Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(title)
        hasher.combine(description)
        hasher.combine(imageUrl)
        hasher.combine(videoUrl)
    }
    
    static func == (lhs: Drill, rhs: Drill) -> Bool {
          return lhs.id == rhs.id
      }
}

struct Video: Codable {
    let title: String
    let videoUrl: String
}
