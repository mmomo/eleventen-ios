//
//  Login.swift
//  ElevenTen
//
//  Created by Jorge Romo on 19/04/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Iniciar Sesión")
                    .font(.largeTitle)
                    .bold()

                TextField("Correo electrónico", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)

                ZStack(alignment: .trailing) {
                    Group {
                        if viewModel.showPassword {
                            TextField("Contraseña", text: $viewModel.password)
                        } else {
                            SecureField("Contraseña", text: $viewModel.password)
                        }
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)

                    Button(action: {
                        viewModel.showPassword.toggle()
                    }) {
                        Image(systemName: viewModel.showPassword ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing)
                    }
                }

                if viewModel.isLoading {
                    ProgressView()
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                Button(action: {
                    viewModel.login()
                }) {
                    Text("Entrar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.brandButtonBackground)
                        .cornerRadius(10)
                }

                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
        }
        .fullScreenCover(isPresented: $viewModel.isLoggedIn) {
            Text("Bienvenido, \(viewModel.user?.name ?? "")")
                .font(.title)
        }
    }
}

