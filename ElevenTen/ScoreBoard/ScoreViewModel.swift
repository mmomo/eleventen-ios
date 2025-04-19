import Foundation
import WatchConnectivity
import SwiftUI

class ScoreViewModel: NSObject, ObservableObject, WCSessionDelegate {

    @Published var scorePlayer1: [Int] = [0, 0, 0]
    @Published var scorePlayer2: [Int] = [0, 0, 0]
    @Published var currentSponsorIndex: Int = 0
    @Published var selectedPlayer: Int?
    @Published var isPlayer1Serving = false
    @Published var isPlayer2Serving = false
    @Published var timeoutsPlayer1: Int = 0
    @Published var timeoutsPlayer2: Int = 0
    @Published var appealsPlayer1: Int = 0
    @Published var appealsPlayer2: Int = 0
    @Published var isTimeoutActive = false
    @Published var timeoutRemaining: Int = 120
    @Published var timeoutPlayerName: String = ""

    let player1Name: String = "Jugador 1"
    let player2Name: String = "Jugador 2"

    private var timeoutTimer: Timer?

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

    func setServingPlayer(_ player: Int) {
        selectedPlayer = player
        isPlayer1Serving = (player == 1)
        isPlayer2Serving = (player == 2)
    }

    func incrementScore(for player: Int, set: Int) {
        if player == 1 {
            scorePlayer1[set] += 1
        } else {
            scorePlayer2[set] += 1
        }
        advanceSponsor()
    }

    func startTimeout(for playerName: String) {
        timeoutPlayerName = playerName
        timeoutRemaining = 120
        isTimeoutActive = true

        timeoutTimer?.invalidate()
        timeoutTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeoutRemaining > 0 {
                self.timeoutRemaining -= 1
            } else {
                self.timeoutTimer?.invalidate()
                self.isTimeoutActive = false
            }
        }
    }

    func cancelTimeout() {
        timeoutTimer?.invalidate()
        isTimeoutActive = false
    }

    func advanceSponsor() {
        currentSponsorIndex += 1
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            if let action = message["action"] as? String {
                switch action {
                case "incrementPlayer1":
                    if let set = message["set"] as? Int, set < self.scorePlayer1.count {
                        self.scorePlayer1[set] += 1
                        self.advanceSponsor()
                    }
                case "incrementPlayer2":
                    if let set = message["set"] as? Int, set < self.scorePlayer2.count {
                        self.scorePlayer2[set] += 1
                        self.advanceSponsor()
                    }
                case "setServing":
                    if let player = message["player"] as? Int {
                        self.setServingPlayer(player)
                    }
                case "timeout":
                    if let player = message["player"] as? Int {
                        if player == 1 {
                            self.timeoutsPlayer1 += 1
                            self.startTimeout(for: self.player1Name)
                        } else {
                            self.timeoutsPlayer2 += 1
                            self.startTimeout(for: self.player2Name)
                        }
                    }
                case "appeal":
                    if let player = message["player"] as? Int {
                        if player == 1 {
                            self.appealsPlayer1 += 1
                        } else {
                            self.appealsPlayer2 += 1
                        }
                    }
                default:
                    break
                }
            }
        }
    }

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
                case "setServing":
                    if let player = message["player"] as? Int {
                        self.setServingPlayer(player)
                    }
                default:
                    break
                }
            }

            replyHandler([
                "scorePlayer1": self.scorePlayer1,
                "scorePlayer2": self.scorePlayer2
            ])
        }
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("❌ Error al activar WCSession en iOS: \(error.localizedDescription)")
        } else {
            print("✅ WCSession activada en iOS: \(activationState.rawValue)")
            sendPlayerNamesToWatch()
        }
    }

    func sendPlayerNamesToWatch() {
        if WCSession.default.isReachable {
            WCSession.default.sendMessage([
                "player1Name": player1Name,
                "player2Name": player2Name
            ], replyHandler: nil)
        }
    }

    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }
    #endif
}
