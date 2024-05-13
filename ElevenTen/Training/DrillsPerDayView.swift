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
        VStack {
            Spacer().frame(height: 32)
            List(day.drills, id: \.self) { drill in
                NavigationLink(destination: DrillDetailView(drill: drill)) {
                    VStack(alignment: .leading) {
                        Text(drill.title)
                            .font(.headline)
                    }
                }
            }
            .navigationBarTitle(Text(day.dayName), displayMode: .inline)
        }
    }
}
