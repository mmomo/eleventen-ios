//
//  ProgramDetailView.swift
//  ElevenTen
//
//  Created by Jorge Romo on 26/04/24.
//

import SwiftUI

struct ProgramDetailView: View {
    let program: Program

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(program.programName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.brandText)

                Text(program.duration)
                    .font(.subheadline)
                    .foregroundColor(.brandSecondaryText)

                Divider().background(Color.brandDivider)

                VStack(alignment: .leading, spacing: 12) {
                    ForEach(program.days, id: \..id) { day in
                        NavigationLink(destination: DrillsPerDayView(day: day)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(day.dayName)
                                        .font(.headline)
                                        .foregroundColor(.brandText)
                                    Text("\(day.drills.count) drills")
                                        .font(.footnote)
                                        .foregroundColor(.brandSecondaryText)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.brandSecondaryText)
                            }
                            .padding()
                            .background(Color.brandListBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color.brandBackground.ignoresSafeArea())
        .navigationTitle("Programa")
        .navigationBarTitleDisplayMode(.inline)
    }
}
