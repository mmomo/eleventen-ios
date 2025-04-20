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

    init() {
        fetchProgramsFromAPI()
    }

    func fetchProgramsFromAPI() {
        guard let url = URL(string: "https://eleventenbackend.onrender.com/api/programs") else {
            print("❌ URL inválida")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error en fetch: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("❌ No data recibida")
                return
            }

            do {
                let programs = try JSONDecoder().decode([Program].self, from: data)
                DispatchQueue.main.async {
                    self.programs = programs
                    self.currentProgram = programs.first
                }
            } catch {
                print("❌ Error al decodificar: \(error)")
            }

        }.resume()
    }

    func getDrillsForToday() -> [Drill] {
        return programs.first?.days.first?.drills ?? []
    }
}
