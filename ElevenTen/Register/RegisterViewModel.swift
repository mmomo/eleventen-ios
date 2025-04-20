//
//  RegisterViewModel.swift
//  ElevenTen
//
//  Created by Jorge Romo on 19/04/25.
//

import Foundation

@MainActor
class RegisterViewModel: ObservableObject {
    @Published var name = ""
    @Published var gender = "masculino"
    @Published var age = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var showPassword = false
    @Published var showConfirmPassword = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isRegistered = false
    @Published var user: RegisteredUser?

    let genders = ["masculino", "femenino", "otro"]

    func register() {
        guard !name.isEmpty,
              !gender.isEmpty,
              !age.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              !confirmPassword.isEmpty else {
            errorMessage = "Por favor llena todos los campos"
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Las contraseñas no coinciden"
            return
        }

        guard let ageInt = Int(age) else {
            errorMessage = "La edad debe ser un número"
            return
        }

        guard let url = URL(string: "https://eleventenbackend.onrender.com/api/auth/register") else {
            errorMessage = "URL inválida"
            return
        }

        isLoading = true
        errorMessage = nil

        let body: [String: Any] = [
            "name": name,
            "gender": gender,
            "age": ageInt,
            "email": email,
            "password": password
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            errorMessage = "Error al codificar datos"
            isLoading = false
            return
        }

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let decoded = try JSONDecoder().decode(UserRegisterModel.self, from: data)

                if decoded.success {
                    self.user = decoded.user
                    self.isRegistered = true
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
