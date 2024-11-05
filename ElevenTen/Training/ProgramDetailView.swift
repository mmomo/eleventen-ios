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
        VStack {
            Spacer().frame(height: 32)
            List(program.days, id: \.id) { day in
                NavigationLink(destination: DrillsPerDayView(day: day)) {
                    Text(day.dayName)
                        .font(.headline)
                }
            }
        .navigationBarTitle(Text(program.programName), displayMode: .inline)
        }
    }
}
