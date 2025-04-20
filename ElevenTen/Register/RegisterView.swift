//
//  RegisterView.swift
//  ElevenTen
//
//  Created by Jorge Romo on 19/04/25.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Text("Crear cuenta")
                        .font(.largeTitle)
                        .bold()

                    TextField("Nombre", text: $viewModel.name)
                        .textContentType(.name)
                        .autocapitalization(.words)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)

                    Picker("Género", selection: $viewModel.gender) {
                        ForEach(viewModel.genders, id: \.self) {
                            Text($0.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)

                    TextField("Edad", text: $viewModel.age)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)

                    TextField("Correo electrónico", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)

                    SecureField("Contraseña", text: $viewModel.password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)

                    SecureField("Confirmar contraseña", text: $viewModel.confirmPassword)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)

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
                        viewModel.register()
                    }) {
                        Text("Registrarse")
                            .font(.headline)
                            .foregroundColor(.brandButtonText)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.brandButtonBackground)
                            .cornerRadius(10)
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationBarTitle("Registro", displayMode: .inline)
        }
        .alert(isPresented: $viewModel.isRegistered) {
            Alert(
                title: Text("¡Registro exitoso!"),
                message: Text("Bienvenido, \(viewModel.user?.name ?? "")"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
