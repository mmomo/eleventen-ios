//
//  DrillsPerDayView.swift
//  ElevenTen
//
//  Created by Jorge Romo on 26/04/24.
//

import SwiftUI

struct DrillsPerDayView: View {
    let day: Day

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(day.dayName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.brandText)

                Divider().background(Color.brandDivider)

                ForEach(day.drills, id: \..id) { drill in
                    NavigationLink(destination: DrillDetailView(drill: drill)) {
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

                Spacer(minLength: 40)
            }
            .padding()
        }
        .background(Color.brandBackground.ignoresSafeArea())
        .navigationTitle("\(day.dayName)")
        .navigationBarTitleDisplayMode(.inline)
    }
}
