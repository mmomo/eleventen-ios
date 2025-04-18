//
//  WatchSessionManager.swift
//  ElevenTen
//
//  Created by Jorge Romo on 07/04/25.
//

import Foundation
import WatchConnectivity

class WatchSessionManager: NSObject, WCSessionDelegate {
    static let shared = WatchSessionManager()

    override private init() {
        super.init()
    }

    func activate() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Watch session activada con estado: \(activationState.rawValue)")
    }
}
