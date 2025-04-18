//
//  ElevenTenWatchApp.swift
//  ElevenTenWatch Watch App
//
//  Created by Jorge Romo on 07/04/25.
//

import SwiftUI
import WatchConnectivity

@main
struct ElevenTenWatch_Watch_AppApp: App {

    init() {
        WatchSessionManager.shared.activate()
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                WatchScoreView()
            }
        }
    }
}
