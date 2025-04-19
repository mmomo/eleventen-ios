import SwiftUI

struct ScoreSettingsView: View {
    @State private var player1Name: String = ""
    @State private var player2Name: String = ""
    @State private var showingScoreBoard = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .onTapGesture { hideKeyboard() }

                VStack(spacing: 20) {
                    // Introducción
                    HStack {
                        Text("Introduce los nombres de los jugadores")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)

                    // TextFields
                    Group {
                        TextField("Nombre del Jugador 1", text: $player1Name)
                        TextField("Nombre del Jugador 2", text: $player2Name)
                    }
                    .padding()
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .foregroundColor(.black)

                    // Instrucciones
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Instrucciones de uso")
                                .font(.headline)
                            Spacer()
                        }
                        .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                InstructionStep(imageName: "arrow.up", description: "Swipe arriba\n+1 punto")
                                InstructionStep(imageName: "arrow.down", description: "Swipe abajo\n-1 punto")
                                InstructionStep(imageName: "person.crop.circle", description: "Toca el nombre\npara servicio")
                                InstructionStep(imageName: "app.badge", description: "Toca el logo\npara más opciones")
                                InstructionStep(imageName: "applewatch", description: "Controla desde\nApple Watch")
                            }
                            .padding(.horizontal)
                        }
                    }

                    // Botón comenzar
                    Button(action: {
                        showingScoreBoard = true
                    }) {
                        Text("Comenzar")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.brandRed)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }

                    Spacer()
                }
                .navigationBarTitle(Text("Marcador"), displayMode: .automatic)
                .fullScreenCover(isPresented: $showingScoreBoard) {
                    ScoreBoardView(player1Name: player1Name, player2Name: player2Name)
                }
            }
        }
    }

    private func hideKeyboard() {
        #if canImport(UIKit)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #endif
    }
}

struct InstructionStep: View {
    let imageName: String
    let description: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.brandRed)

            Text(description)
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .frame(height: 40)
        }
        .frame(width: 120, height: 140)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}
