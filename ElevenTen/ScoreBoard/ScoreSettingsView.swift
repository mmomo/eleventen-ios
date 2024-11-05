//
//  ScoreSettingsView.swift
//  ElevenTen
//
//  Created by Jorge Romo on 01/05/24.
//

import Foundation
import SwiftUI

struct ScoreSettingsView: View {
    @State private var numberOfSets: Int = 3
    @State private var player1Name: String = ""
    @State private var player2Name: String = ""
    @State private var instructionText: String = """
    Para aumentar el marcador, haz un gesto swipe hacia arriba. \
    Para disminuir, haz un swipe hacia abajo. Para indicar quién tiene el servicio, \
    toca el nombre del jugador.
    """
    
    @State private var showingScoreBoard = false

    var body: some View {
        NavigationView {
            VStack {
                // Number of Sets
                Picker(selection: $numberOfSets, label: Text("Número de Sets")) {
                    Text("3 Sets").tag(3)
                    Text("5 Sets").tag(5)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Player 1 Name
                TextField("Nombre del Jugador 1", text: $player1Name)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Player 2 Name
                TextField("Nombre del Jugador 2", text: $player2Name)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Instruction Text
                Text(instructionText)
                    .padding()
                
                // Comenzar Button
                Button(action: {
                    showingScoreBoard = true
                }, label: {
                    Text("Comenzar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                .padding()
                .fullScreenCover(isPresented: $showingScoreBoard) {
                    ScoreBoardView(player1Name: player1Name, player2Name: player2Name)
                }
                
                Spacer()
            }
            .navigationBarTitle(Text("Marcador"), displayMode: .inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreSettingsView()
    }
}
