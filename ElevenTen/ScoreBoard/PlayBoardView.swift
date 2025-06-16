import SwiftUI

struct Line: Equatable {
    var points = [CGPoint]()
    var color: Color = .blue
    var lineWidth: Double = 10.0
}

extension CGSize {
    static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}

struct PlayBoardView: View {
    @Environment(\.dismiss) var dismiss

    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    @State private var thickness: Double = 10.0

    @State private var player1Position: CGSize = .zero
    @State private var player2Position: CGSize = .zero
    @State private var ballPosition: CGSize = .zero

    @GestureState private var player1Drag: CGSize = .zero
    @GestureState private var player2Drag: CGSize = .zero
    @GestureState private var ballDrag: CGSize = .zero

    let iconSize: CGFloat = 60
    let spacing: CGFloat = 16

    var hasContent: Bool {
        !lines.isEmpty || player1Position != .zero || player2Position != .zero || ballPosition != .zero
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Fondo de la cancha
                Image("court")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()

                // Área de dibujo
                Canvas { context, size in
                    for line in lines {
                        var path = Path()
                        path.addLines(line.points)
                        context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                    }
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            currentLine.points.append(value.location)
                        }
                        .onEnded { _ in
                            lines.append(currentLine)
                            currentLine = Line(points: [], color: currentLine.color, lineWidth: thickness)
                        }
                )

                // Controles superiores
                VStack {
                    HStack(spacing: 12) {
                        // Botón cerrar
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.primary)
                                .padding(10)
                                .background(Color.white.opacity(0.8))
                                .clipShape(Circle())
                        }

                        // Botón borrar todo
                        Button(action: {
                            lines.removeAll()
                            player1Position = .zero
                            player2Position = .zero
                            ballPosition = .zero
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(hasContent ? .red : .gray)
                                .padding(10)
                                .background(Color.white.opacity(0.8))
                                .clipShape(Circle())
                        }
                        .disabled(!hasContent)

                        // Jugadores y pelota
                        HStack(spacing: spacing) {
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: iconSize, height: iconSize)
                                .foregroundColor(.blue)
                                .offset(player1Position + player1Drag)
                                .gesture(dragGesture(position: $player1Position, drag: $player1Drag))

                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: iconSize, height: iconSize)
                                .foregroundColor(.red)
                                .offset(player2Position + player2Drag)
                                .gesture(dragGesture(position: $player2Position, drag: $player2Drag))

                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: iconSize * 0.6, height: iconSize * 0.6)
                                .foregroundColor(.cyan)
                                .offset(ballPosition + ballDrag)
                                .gesture(dragGesture(position: $ballPosition, drag: $ballDrag))
                        }

                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
                    .background(.ultraThinMaterial)

                    Spacer()

                    // Panel inferior
                    VStack {
                        HStack {
                            Slider(value: $thickness, in: 1...20)
                                .frame(width: 150)
                                .onChange(of: thickness) { newValue in
                                    currentLine.lineWidth = newValue
                                }

                            Spacer()

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach([Color.red, .orange, .green, .blue, .purple], id: \.self) { color in
                                        Circle()
                                            .fill(color)
                                            .frame(width: 24, height: 24)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.white, lineWidth: currentLine.color == color ? 3 : 0)
                                            )
                                            .onTapGesture {
                                                currentLine.color = color
                                            }
                                    }
                                }
                                .padding(.horizontal, 8)
                            }
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                    }
                }
            }
        }
    }

    // Gesture general reutilizable
    private func dragGesture(position: Binding<CGSize>, drag: GestureState<CGSize>) -> some Gesture {
        DragGesture()
            .updating(drag) { value, state, _ in state = value.translation }
            .onEnded { value in
                position.wrappedValue.width += value.translation.width
                position.wrappedValue.height += value.translation.height
            }
    }
}

#Preview {
    PlayBoardView()
}
