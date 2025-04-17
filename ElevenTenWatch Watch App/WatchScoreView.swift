import SwiftUI

struct WatchScoreView: View {
    @StateObject private var viewModel = WatchScoreViewModel()
    @State private var selectedPlayer: Int = 1 // 1 = Player 1, 2 = Player 2
    let sets = 3

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 16) {
                Text("Marcador")
                    .font(.headline)

                // Selector de jugador
                HStack {
                    Button(action: { selectedPlayer = 1 }) {
                        Text("Jugador 1")
                            .font(.caption)
                            .padding(6)
                            .background(selectedPlayer == 1 ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }

                    Button(action: { selectedPlayer = 2 }) {
                        Text("Jugador 2")
                            .font(.caption)
                            .padding(6)
                            .background(selectedPlayer == 2 ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                }

                Divider()

                VStack(spacing: 10) {
                    Text("Sets - Jugador \(selectedPlayer)")
                        .font(.subheadline)

                    ForEach(0..<sets, id: \.self) { set in
                        HStack {
                            Button(action: {
                                viewModel.sendIncrement(player: selectedPlayer, set: set)
                            }) {
                                Text("Set \(set + 1) +1")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)

                            Text("\(viewModel.getScore(for: selectedPlayer, set: set))")
                                .font(.title3)
                                .frame(width: 40)
                        }
                    }
                }
            }
            .padding()
        }
    }
}
