//
//  ScoreBoardView.swift
//  ElevenTen
//
//  Created by Jorge Romo on 01/05/24.
//

import SwiftUI

struct ScoreBoardView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var scorePlayer1: [Int] = [0, 0, 0] // Array para los sets del jugador 1
    @State private var scorePlayer2: [Int] = [0, 0, 0] // Array para los sets del jugador 2
    @State private var selectedPlayer: Int? // 1 para el jugador 1, 2 para el jugador 2
    @State private var isPlayer1Serving: Bool = false
    @State private var isPlayer2Serving: Bool = false
    @State private var tapCount: Int = 0
    var player1Name: String
    var player2Name: String
    
    init(player1Name: String, player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
    }

    var body: some View {
            VStack(spacing: 20) {
                // Imagen
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                // Encabezados de los sets
                HStack {
                    Spacer()
                    Spacer() // Espaciador adicional
                    Text("Jugadores")
                        .font(.title) // Aumenta el tamaño del texto
                    
                    // Encabezados de los sets
                    ForEach(0..<3) { index in
                        Text("Set \(index + 1)")
                            .font(.title) // Aumenta el tamaño del texto
                        Spacer()
                    }
                }
                
                // Fila del jugador 1
                HStack {
                    Spacer()
                    // Botón del jugador 1
                    Button(action: {
                        selectedPlayer = 1
                        isPlayer1Serving = true
                        isPlayer2Serving = false
                    }, label: {
                        Text(player1Name)
                            .font(.title) // Aumenta el tamaño del texto
                            .padding()
                            .background(selectedPlayer == 1 ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    })
                    .overlay(
                        Image(systemName: "circle.fill")
                            .foregroundColor(isPlayer1Serving ? .green : .clear)
                            .offset(x: -20)
                            .opacity(selectedPlayer == 1 ? 1 : 0)
                    )
                    Spacer() // Espaciador adicional
                    // Scores del jugador 1
                    ForEach(0..<3) { index in
                        VStack {
                            Text("\(scorePlayer1[index])")
                                .font(.title) // Aumenta el tamaño del texto
                                .padding(.horizontal)
                                .frame(width: 60, height: 60)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
                                .gesture(DragGesture(minimumDistance: 5, coordinateSpace: .local)
                                    .onEnded({ value in
                                        if value.translation.height < -10 {
                                            scorePlayer1[index] += 1 // Swipe hacia arriba
                                        } else if value.translation.height > 10 {
                                            scorePlayer1[index] -= 1 // Swipe hacia abajo
                                        }
                                    }))
                        }
                        Spacer()
                    }
                }
                
                // Fila del jugador 2
                HStack {
                    Spacer()
                    // Botón del jugador 2
                    Button(action: {
                        selectedPlayer = 2
                        isPlayer1Serving = false
                        isPlayer2Serving = true
                    }, label: {
                        Text(player2Name)
                            .font(.title) // Aumenta el tamaño del texto
                            .padding()
                            .background(selectedPlayer == 2 ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    })
                    .overlay(
                        Image(systemName: "circle.fill")
                            .foregroundColor(isPlayer2Serving ? .green : .clear)
                            .offset(x: -20)
                            .opacity(selectedPlayer == 2 ? 1 : 0)
                    )
                    Spacer() // Espaciador adicional
                    // Scores del jugador 2
                    ForEach(0..<3) { index in
                        VStack {
                            Text("\(scorePlayer2[index])")
                                .font(.title) // Aumenta el tamaño del texto
                                .padding(.horizontal)
                                .frame(width: 60, height: 60)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
                                .gesture(DragGesture(minimumDistance: 5, coordinateSpace: .local)
                                    .onEnded({ value in
                                        if value.translation.height < -10 {
                                            scorePlayer2[index] += 1 // Swipe hacia arriba
                                        } else if value.translation.height > 10 {
                                            scorePlayer2[index] -= 1 // Swipe hacia abajo
                                        }
                                    }))
                        }
                        Spacer()
                    }
                }
            }
        .contentShape(Rectangle()) // Define la forma del área sensible para el gesto
        .onTapGesture(count: 3) {
            tapCount += 1
            if tapCount == 3 {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .gesture(DragGesture().exclusively(before: TapGesture(count: 3)).onEnded { _ in
            // Código de manejo del gesto de arrastre
        })
    }
}
