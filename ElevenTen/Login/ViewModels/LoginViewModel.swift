//
//  LoginViewModel.swift
//  ElevenTen
//
//  Created by Jorge Romo on 12/03/25.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var loginMessage: String = ""
    @Published var isLoggedIn: Bool = false

    private let apiService = APIService()

    func login() {
        apiService.login(username: username, password: password) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    self.loginMessage = response.message
                    print("✅ Login exitoso, Token: \(response.token)")
                    print("📄 Respuesta completa: \(response)")
                case .failure(let error):
                    self.loginMessage = "Error: \(error.localizedDescription)"
                    self.isLoggedIn = false
                    print("❌ Error en login: \(error.localizedDescription)")
                }
            }
        }
    }
}

