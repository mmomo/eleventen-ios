import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Spacer().frame(height: 5)

                    HStack {
                        Text("Welcome {{user}} 👋")
                            .foregroundColor(.brandText)
                        Spacer()
                    }

                    if let currentProgram = viewModel.currentProgram {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Continue")
                                .fontWeight(.heavy)
                                .foregroundColor(.brandText)

                            NavigationLink(destination: ProgramDetailView(program: currentProgram)) {
                                CellView(program: currentProgram)
                                    .frame(width: 300, height: 250)
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Programs")
                            .fontWeight(.heavy)
                            .foregroundColor(.brandText)

                        Text("Created to help you improve your racquet skills and prepare for new challenges.")
                            .italic()
                            .foregroundColor(.gray)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.programs, id: \.programName) { program in
                                    CellView(program: program)
                                        .frame(width: 200, height: 150)
                                }
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Workouts")
                            .fontWeight(.heavy)
                            .foregroundColor(.brandText)

                        ForEach(viewModel.getDrillsForToday().prefix(5), id: \.id) { drill in

                            WorkoutMiniView(drill: drill)
                        }
                    }

                    Spacer()
                }
                .padding()
                .background(Color.brandBackground)
            }
            .navigationTitle("Inicio")
            .navigationBarTitleDisplayMode(.automatic)
            .background(Color.brandBackground.ignoresSafeArea())
        }
    }
}

struct CellView: View {
    let program: Program

    var body: some View {
        ZStack(alignment: .bottom) {
            Image("racquetball_program")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .clipped()

            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                startPoint: .bottom,
                endPoint: .top
            )
            .frame(height: 80)

            HStack {
                Text(program.programName)
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                Spacer()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct WorkoutMiniView: View {
    let drill: Drill

    var body: some View {
        HStack(spacing: 12) {
            Image("racquetball_man")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 4) {
                Text(drill.title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.brandText)
                Text(drill.description)
                    .font(.footnote)
                    .lineLimit(1)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
    }
}

#Preview {
    DashboardView(viewModel: DashboardViewModel())
}
