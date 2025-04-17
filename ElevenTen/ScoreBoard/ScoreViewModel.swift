import Foundation
import WatchConnectivity
import SwiftUI

class ScoreViewModel: NSObject, ObservableObject, WCSessionDelegate {

    @Published var scorePlayer1: [Int] = [0, 0, 0]
    @Published var scorePlayer2: [Int] = [0, 0, 0]
    @Published var currentSponsorIndex: Int = 0

    let sponsorImages = ["sponsor0", "sponsor1", "sponsor2", "sponsor3", "sponsor4"]

    var currentSponsor: String {
        sponsorImages[currentSponsorIndex % sponsorImages.count]
    }

    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    func incrementScore(for player: Int, set: Int) {
        if player == 1 {
            scorePlayer1[set] += 1
        } else {
            scorePlayer2[set] += 1
        }
        advanceSponsor()
    }

    func advanceSponsor() {
        currentSponsorIndex += 1
    }

    // ✅ Para mensajes sin respuesta (opcional)
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            if let action = message["action"] as? String,
               let set = message["set"] as? Int {
                switch action {
                case "incrementPlayer1":
                    if set < self.scorePlayer1.count {
                        self.scorePlayer1[set] += 1
                        self.advanceSponsor()
                    }
                case "incrementPlayer2":
                    if set < self.scorePlayer2.count {
                        self.scorePlayer2[set] += 1
                        self.advanceSponsor()
                    }
                default:
                    break
                }
            }
        }
    }

    // ✅ Para mensajes CON respuesta desde el Watch
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        DispatchQueue.main.async {
            if let action = message["action"] as? String,
               let set = message["set"] as? Int {
                switch action {
                case "incrementPlayer1":
                    if set < self.scorePlayer1.count {
                        self.scorePlayer1[set] += 1
                        self.advanceSponsor()
                    }
                case "incrementPlayer2":
                    if set < self.scorePlayer2.count {
                        self.scorePlayer2[set] += 1
                        self.advanceSponsor()
                    }
                default:
                    break
                }
            }

            // ✅ Responder al Apple Watch con puntajes actualizados
            replyHandler([
                "scorePlayer1": self.scorePlayer1,
                "scorePlayer2": self.scorePlayer2
            ])
        }
    }

    // ✅ Requerido por WCSessionDelegate
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("❌ Error al activar WCSession en iOS: \(error.localizedDescription)")
        } else {
            print("✅ WCSession activada en iOS: \(activationState.rawValue)")
        }
    }

    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }
    #endif
}
