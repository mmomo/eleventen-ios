//
//  DashboardViewModel.swift
//  ElevenTen
//
//  Created by César Venzor on 06/04/25.
//

import Foundation
import SwiftUI

class DashboardViewModel: ObservableObject {
    @Published var programs: [Program] = []
    @Published var currentProgram: Program?
    
    init(jsonData: Data? = nil) {
        if let jsonData = jsonData {
            loadProgramsFrom(jsonData: jsonData)
        } else {
            loadProgramsFromBundle()
        }
    }
    
    private func loadProgramsFromBundle() {
        if let fileUrl = Bundle.main.url(forResource: "programs", withExtension: "json"),
           let jsonData = try? Data(contentsOf: fileUrl) {
            loadProgramsFrom(jsonData: jsonData)
        } else {
            print("Failed to load file from bundle")
        }
    }
    
    private func loadProgramsFrom(jsonData: Data) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
            let programsArray = jsonObject?["programs"] as? [[String: Any]] ?? []
            let decodedPrograms = try JSONDecoder().decode([Program].self,
                                                           from: JSONSerialization.data(withJSONObject: programsArray))
            self.programs = decodedPrograms
            self.currentProgram = decodedPrograms.first
        } catch {
            print("Decoding error: \(error)")
        }
    }
    
    func getDrillsForToday() -> [Drill] {
        if let drills = self.programs.first?.days.first?.drills {
            return drills
        } else {
            return []
        }
    }
}
