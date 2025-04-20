import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel = DashboardViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    Text("Welcome 👋")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.brandText)

                    if let currentProgram = viewModel.currentProgram {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Continue Program")
                                .font(.headline)
                                .foregroundColor(.brandText)

                            let title = currentProgram.programName
                            let subtitle = currentProgram.duration

                            NavigationLink(destination: ProgramDetailView(program: currentProgram)) {
                                CardView(title: title, subtitle: subtitle)
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("All Programs")
                            .font(.headline)
                            .foregroundColor(.brandText)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                let programs = viewModel.programs
                                ForEach(viewModel.programs, id: \.id) { program in
                                    let title = program.programName
                                    let subtitle = program.level

                                    NavigationLink(destination: ProgramDetailView(program: program)) {
                                        CardView(title: title, subtitle: subtitle)
                                    }
                                }
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Today's Workouts")
                            .font(.headline)
                            .foregroundColor(.brandText)

                        let drills = viewModel.getDrillsForToday().prefix(5)
                        ForEach(drills, id: \.id) { drill in
                            DrillCardView(drill: drill)
                        }

                    }

                    Spacer(minLength: 40)
                }
                .padding()
            }
            .background(Color.brandBackground.ignoresSafeArea())
            .navigationTitle("Inicio")
        }
    }
}

struct CardView: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)

            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding()
        .frame(width: 220, height: 120)
        .background(LinearGradient(colors: [.brandRed, .brandBlack], startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 4)
    }
}

struct DrillCardView: View {
    let drill: Drill

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(drill.title)
                .font(.headline)
                .foregroundColor(.brandText)

            Text(drill.description ?? "")
                .font(.subheadline)
                .foregroundColor(.brandSecondaryText)
                .lineLimit(2)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.brandListBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
