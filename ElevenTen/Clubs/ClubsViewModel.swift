//
//  ClubsViewModel.swift
//  ElevenTen
//
//  Created by Jorge Romo on 18/04/25.
//

import Foundation

@MainActor
class ClubsViewModel: ObservableObject {
    // Variable para guardar los lugares
    @Published var racquetballPlaces: [PlaceAnnotation] = []
    //
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchPlaces() {
        guard let url = URL(string: "https://eleventenbackend.onrender.com/api/locations") else {
            self.errorMessage = "URL inválida"
            return
        }

        isLoading = true
        errorMessage = nil

        Task {
            do {
                let (data, dataResponse) = try await URLSession.shared.data(from: url)
                print(dataResponse)
                let decoder = JSONDecoder()
                let places = try decoder.decode([PlaceAnnotation].self, from: data)
                racquetballPlaces = places
            } catch {
                errorMessage = "Error al cargar los lugares: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
}
