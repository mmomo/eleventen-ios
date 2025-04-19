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

                // Selector de jugador con nombres personalizados
                HStack {
                    Button(action: {
                        selectedPlayer = 1
                        viewModel.setServingPlayer(1)
                    }) {
                        Text(viewModel.player1Name)
                            .font(.caption)
                            .padding(6)
                            .background(selectedPlayer == 1 ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }

                    Button(action: {
                        selectedPlayer = 2
                        viewModel.setServingPlayer(2)
                    }) {
                        Text(viewModel.player2Name)
                            .font(.caption)
                            .padding(6)
                            .background(selectedPlayer == 2 ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                }

                Divider()

                VStack(spacing: 10) {
                    Text("Sets - \(selectedPlayer == 1 ? viewModel.player1Name : viewModel.player2Name)")
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

                Divider()

                // Botones de Tiempo fuera y Apelación
                HStack {
                    Button(action: {
                        viewModel.sendTimeout(for: selectedPlayer)
                    }) {
                        Text("Tiempo fuera")
                            .font(.caption2)
                            .padding(6)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }

                    Button(action: {
                        viewModel.sendAppeal(for: selectedPlayer)
                    }) {
                        Text("Apelación")
                            .font(.caption2)
                            .padding(6)
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding()
        }
    }
}
