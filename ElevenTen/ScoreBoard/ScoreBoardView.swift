import SwiftUI

struct ScoreBoardView: View {
    @StateObject var viewModel = ScoreViewModel()

    @Environment(\.presentationMode) var presentationMode
    @State private var showExitButton: Bool = false
    @State private var showActionSheet: Bool = false

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
                    ZStack(alignment: .topLeading) {
                        Image(viewModel.currentSponsor)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: totalHeight * 0.4)
                            .clipped()
                            .blur(radius: 20)

                        HStack {
                            Spacer()
                            Image(viewModel.currentSponsor)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: totalHeight * 0.4)
                                .clipped()
                            Spacer()
                        }

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
                                .onTapGesture {
                                    showExitButton = true
                                    showActionSheet = true

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        withAnimation {
                                            showExitButton = false
                                        }
                                    }
                                }

                            Spacer()
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 50)                    }

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

                    jugadorRow(
                        name: player1Name,
                        isServing: viewModel.isPlayer1Serving,
                        selected: viewModel.selectedPlayer == 1,
                        nameColumnWidth: nameColumnWidth,
                        setColumnWidth: setColumnWidth,
                        idealCellSize: idealCellSize,
                        score: viewModel.scorePlayer1,
                        timeouts: viewModel.timeoutsPlayer1,
                        appeals: viewModel.appealsPlayer1,
                        onSelect: { viewModel.setServingPlayer(1) },
                        onSwipeUp: { index in viewModel.incrementScore(for: 1, set: index) },
                        onSwipeDown: { index in
                            viewModel.scorePlayer1[index] = max(0, viewModel.scorePlayer1[index] - 1)
                        }
                    )

                    jugadorRow(
                        name: player2Name,
                        isServing: viewModel.isPlayer2Serving,
                        selected: viewModel.selectedPlayer == 2,
                        nameColumnWidth: nameColumnWidth,
                        setColumnWidth: setColumnWidth,
                        idealCellSize: idealCellSize,
                        score: viewModel.scorePlayer2,
                        timeouts: viewModel.timeoutsPlayer2,
                        appeals: viewModel.appealsPlayer2,
                        onSelect: { viewModel.setServingPlayer(2) },
                        onSwipeUp: { index in viewModel.incrementScore(for: 2, set: index) },
                        onSwipeDown: { index in
                            viewModel.scorePlayer2[index] = max(0, viewModel.scorePlayer2[index] - 1)
                        }
                    )

                    Spacer()
                }

                if showExitButton {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.red)
                            .padding(.top, 50)
                            .padding()
                    }
                    .transition(.opacity)
                    .animation(.easeInOut, value: showExitButton)
                }

                if viewModel.isTimeoutActive {
                    ZStack {
                        Color.black.opacity(0.6).ignoresSafeArea()

                        VStack(spacing: 20) {
                            ZStack {
                                Circle()
                                    .stroke(Color.white.opacity(0.2), lineWidth: 20)
                                    .frame(width: 180, height: 180)

                                Circle()
                                    .trim(from: 0, to: CGFloat(Double(120 - viewModel.timeoutRemaining) / 120.0))
                                    .stroke(Color.red, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                                    .rotationEffect(.degrees(-90))
                                    .frame(width: 180, height: 180)
                                    .animation(.easeInOut(duration: 0.5), value: viewModel.timeoutRemaining)

                                Text("\(viewModel.timeoutRemaining / 60):\(String(format: "%02d", viewModel.timeoutRemaining % 60))")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.white)
                            }

                            Text("Tiempo fuera por \(viewModel.timeoutPlayerName)")
                                .font(.title3)
                                .foregroundColor(.white)

                            Button("Reanudar") {
                                viewModel.cancelTimeout()
                            }
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.red)
                            .cornerRadius(10)
                        }
                    }
                }
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("Opciones"), buttons: [
                    .default(Text("Tiempo fuera - \(player1Name)")) {
                        viewModel.timeoutsPlayer1 += 1
                        viewModel.startTimeout(for: player1Name)
                    },
                    .default(Text("Tiempo fuera - \(player2Name)")) {
                        viewModel.timeoutsPlayer2 += 1
                        viewModel.startTimeout(for: player2Name)
                    },
                    .default(Text("Apelación - \(player1Name)")) {
                        viewModel.appealsPlayer1 += 1
                    },
                    .default(Text("Apelación - \(player2Name)")) {
                        viewModel.appealsPlayer2 += 1
                    },
                    .cancel()
                ])
            }
            .edgesIgnoringSafeArea(.all)
        }
    }

    func jugadorRow(
        name: String,
        isServing: Bool,
        selected: Bool,
        nameColumnWidth: CGFloat,
        setColumnWidth: CGFloat,
        idealCellSize: CGFloat,
        score: [Int],
        timeouts: Int,
        appeals: Int,
        onSelect: @escaping () -> Void,
        onSwipeUp: @escaping (Int) -> Void,
        onSwipeDown: @escaping (Int) -> Void
    ) -> some View {
        HStack(spacing: 8) {
            Button(action: onSelect) {
                ZStack(alignment: .topLeading) {
                    VStack(spacing: 4) {
                        Text(name)
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("T: \(timeouts)  A: \(appeals)")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .frame(width: nameColumnWidth, height: idealCellSize)
                    .background(selected ? Color.blue : Color.gray)
                    .cornerRadius(8)

                    if isServing {
                        Image(systemName: "circle.fill")
                            .foregroundColor(.green)
                            .offset(x: -nameColumnWidth / 2 + 12)
                    }
                }
            }

            ForEach(0..<3) { index in
                Text("\(score[index])")
                    .font(.custom("Technology-Bold", size: 50))
                    .foregroundColor(.red)
                    .frame(width: setColumnWidth, height: idealCellSize)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
                    .gesture(
                        DragGesture(minimumDistance: 5)
                            .onEnded { value in
                                if value.translation.height < -10 {
                                    onSwipeUp(index)
                                } else if value.translation.height > 10 {
                                    onSwipeDown(index)
                                }
                            }
                    )
            }
        }
        .padding(.horizontal, 32)
    }
}
