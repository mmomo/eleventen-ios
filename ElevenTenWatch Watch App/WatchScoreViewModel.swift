import Foundation
import WatchConnectivity

class WatchScoreViewModel: NSObject, ObservableObject, WCSessionDelegate {

    @Published var scorePlayer1: [Int] = [0, 0, 0]
    @Published var scorePlayer2: [Int] = [0, 0, 0]
    @Published var player1Name: String = "Jugador 1"
    @Published var player2Name: String = "Jugador 2"

    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    func sendIncrement(player: Int, set: Int) {
        guard WCSession.default.isReachable else {
            print("❌ iPhone no está disponible")
            return
        }

        let action = player == 1 ? "incrementPlayer1" : "incrementPlayer2"

        WCSession.default.sendMessage(["action": action, "set": set], replyHandler: { response in
            if let updatedScore1 = response["scorePlayer1"] as? [Int],
               let updatedScore2 = response["scorePlayer2"] as? [Int] {
                DispatchQueue.main.async {
                    self.scorePlayer1 = updatedScore1
                    self.scorePlayer2 = updatedScore2
                }
            }
        }, errorHandler: { error in
            print("❌ Error enviando mensaje desde Watch: \(error.localizedDescription)")
        })
    }

    func sendTimeout(for player: Int) {
        guard WCSession.default.isReachable else {
            print("iPhone no está disponible")
            return
        }

        WCSession.default.sendMessage(["action": "timeout", "player": player], replyHandler: nil) { error in
            print("❌ Error al enviar timeout: \(error.localizedDescription)")
        }
    }

    func sendAppeal(for player: Int) {
        guard WCSession.default.isReachable else {
            print("iPhone no está disponible")
            return
        }

        WCSession.default.sendMessage(["action": "appeal", "player": player], replyHandler: nil) { error in
            print("❌ Error al enviar apelación: \(error.localizedDescription)")
        }
    }

    func getScore(for player: Int, set: Int) -> Int {
        return player == 1 ? scorePlayer1[set] : scorePlayer2[set]
    }

    func setServingPlayer(_ player: Int) {
        guard WCSession.default.isReachable else {
            print("iPhone no está disponible")
            return
        }

        WCSession.default.sendMessage(["action": "setServing", "player": player], replyHandler: nil) { error in
            print("❌ Error al enviar cambio de servicio: \(error.localizedDescription)")
        }
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("❌ Error al activar WCSession en Watch: \(error.localizedDescription)")
        } else {
            print("✅ WCSession activada en Watch: \(activationState.rawValue)")
        }
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let name1 = message["player1Name"] as? String,
           let name2 = message["player2Name"] as? String {
            DispatchQueue.main.async {
                self.player1Name = name1
                self.player2Name = name2
            }
        }
    }
}
