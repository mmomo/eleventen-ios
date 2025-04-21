//
//  NewsViewModel.swift
//  ElevenTen
//
//  Created by Jorge Romo on 20/04/25.
//

import Foundation

@MainActor
class NewsViewModel: ObservableObject {
    @Published var news: [NewsItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchNews() {
        guard let url = URL(string: "https://eleventenbackend.onrender.com/api/news") else {
            errorMessage = "URL inválida"
            return
        }

        isLoading = true
        errorMessage = nil

        Task { @MainActor in
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoded = try JSONDecoder().decode([NewsItem].self, from: data)
                self.news = decoded
            } catch {
                self.errorMessage = "Error al cargar noticias: \(error.localizedDescription)"
            }
            self.isLoading = false
        }

    }
}
