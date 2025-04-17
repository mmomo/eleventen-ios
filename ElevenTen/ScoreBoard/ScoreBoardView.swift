import SwiftUI

struct ScoreBoardView: View {
    @StateObject var viewModel = ScoreViewModel()

    @Environment(\.presentationMode) var presentationMode
    @State private var selectedPlayer: Int?
    @State private var isPlayer1Serving: Bool = false
    @State private var isPlayer2Serving: Bool = false
    @State private var showExitButton: Bool = false

    var player1Name: String
    var player2Name: String

    init(player1Name: String, player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
    }

    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width - 64
            let totalHeight = geometry.size.height

            let spacing: CGFloat = 8
            let nameColumnWidth = totalWidth * 0.35
            let setColumnWidth = (totalWidth - nameColumnWidth - spacing * 2) / 3
            let idealCellSize = min(setColumnWidth, totalHeight * 0.13)

            ZStack(alignment: .topTrailing) {
                VStack(spacing: 16) {
                    // Banner con fondo desenfocado y logo decorativo
                    ZStack(alignment: .topLeading) {
                        // Fondo desenfocado del patrocinador
                        Image(viewModel.currentSponsor)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: totalHeight * 0.4)
                            .clipped()
                            .blur(radius: 20)

                        // Imagen principal del patrocinador (centrada y clara)
                        HStack {
                            Spacer()

                            Image(viewModel.currentSponsor)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: totalHeight * 0.4)
                                .clipped()

                            Spacer()
                        }

                        // Logo sobrepuesto
                        HStack {
                            Image("logo")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .shadow(radius: 6)

                            Spacer()
                        }
                        .padding(.horizontal, 50)
                        .padding(.top, 16)
                    }

                    // Encabezado
                    HStack(spacing: spacing) {
                        Text("Jugador")
                            .frame(width: nameColumnWidth, height: idealCellSize)
                            .font(.headline)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(6)

                        ForEach(0..<3) { index in
                            Text("Set \(index + 1)")
                                .frame(width: setColumnWidth, height: idealCellSize)
                                .font(.headline)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(6)
                        }
                    }
                    .padding(.horizontal, 32)

                    // Jugador 1
                    HStack(spacing: spacing) {
                        Button(action: {
                            selectedPlayer = 1
                            isPlayer1Serving = true
                            isPlayer2Serving = false
                        }) {
                            ZStack {
                                Text(player1Name)
                                    .frame(width: nameColumnWidth, height: idealCellSize)
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .background(selectedPlayer == 1 ? Color.blue : Color.gray)
                                    .cornerRadius(8)
                                if isPlayer1Serving {
                                    Image(systemName: "circle.fill")
                                        .foregroundColor(.green)
                                        .offset(x: -nameColumnWidth / 2 + 12)
                                }
                            }
                        }

                        ForEach(0..<3) { index in
                            Text("\(viewModel.scorePlayer1[index])")
                                .font(.system(size: 28, weight: .bold))
                                .frame(width: setColumnWidth, height: idealCellSize)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
                                .gesture(
                                    DragGesture(minimumDistance: 5)
                                        .onEnded { value in
                                            if value.translation.height < -10 {
                                                viewModel.incrementScore(for: 1, set: index)
                                            } else if value.translation.height > 10 {
                                                viewModel.scorePlayer1[index] -= 1
                                            }
                                        }
                                )
                        }
                    }
                    .padding(.horizontal, 32)

                    // Jugador 2
                    HStack(spacing: spacing) {
                        Button(action: {
                            selectedPlayer = 2
                            isPlayer1Serving = false
                            isPlayer2Serving = true
                        }) {
                            ZStack {
                                Text(player2Name)
                                    .frame(width: nameColumnWidth, height: idealCellSize)
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .background(selectedPlayer == 2 ? Color.blue : Color.gray)
                                    .cornerRadius(8)
                                if isPlayer2Serving {
                                    Image(systemName: "circle.fill")
                                        .foregroundColor(.green)
                                        .offset(x: -nameColumnWidth / 2 + 12)
                                }
                            }
                        }

                        ForEach(0..<3) { index in
                            Text("\(viewModel.scorePlayer2[index])")
                                .font(.system(size: 28, weight: .bold))
                                .frame(width: setColumnWidth, height: idealCellSize)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
                                .gesture(
                                    DragGesture(minimumDistance: 5)
                                        .onEnded { value in
                                            if value.translation.height < -10 {
                                                viewModel.incrementScore(for: 2, set: index)
                                            } else if value.translation.height > 10 {
                                                viewModel.scorePlayer2[index] -= 1
                                            }
                                        }
                                )
                        }
                    }
                    .padding(.horizontal, 32)

                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .contentShape(Rectangle())
                .onTapGesture {
                    showExitButton = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            showExitButton = false
                        }
                    }
                }

                // Botón flotante para salir
                if showExitButton {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.red)
                            .padding()
                    }
                    .transition(.opacity)
                    .animation(.easeInOut, value: showExitButton)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
