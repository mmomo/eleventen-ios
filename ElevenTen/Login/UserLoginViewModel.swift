//
//  UserLoginViewModel.swift
//  ElevenTen
//
//  Created by Jorge Romo on 19/04/25.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var showPassword = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isLoggedIn = false
    @Published var user: LoggedUser?

    func login() {
        guard let url = URL(string: "https://eleventenbackend.onrender.com/api/auth/login") else {
            self.errorMessage = "URL inválida"
            return
        }

        isLoading = true
        errorMessage = nil

        let body: [String: Any] = [
            "email": email,
            "password": password
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            self.errorMessage = "Error al codificar datos"
            isLoading = false
            return
        }

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let decoded = try JSONDecoder().decode(UserLoginModel.self, from: data)

                if decoded.success {
                    self.user = decoded.user
                    self.isLoggedIn = true
                    // Aquí podrías guardar el token en UserDefaults si lo necesitas
                } else {
                    self.errorMessage = decoded.message
                }
            } catch {
                self.errorMessage = "Error en la conexión o en la respuesta"
            }
            self.isLoading = false
        }
    }
}
