//
//  ContentView.swift
//  ElevenTenWatch Watch App
//
//  Created by Jorge Romo on 07/04/25.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Marcador")

            Button("Player 1 - Set 1 +1") {
                sendMessage(player: 1, set: 0)
            }

            Button("Player 2 - Set 2 +1") {
                sendMessage(player: 2, set: 1)
            }
        }
        .padding()
    }

    func sendMessage(player: Int, set: Int) {
        let action = player == 1 ? "incrementPlayer1" : "incrementPlayer2"
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(["action": action, "set": set], replyHandler: nil, errorHandler: { error in
                print("Error al enviar mensaje: \(error.localizedDescription)")
            })
        } else {
            print("Sesión no disponible")
        }
    }
}
