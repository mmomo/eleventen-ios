//
//  DashboardView.swift
//  ElevenTen
//
//  Created by César Venzor on 06/04/25.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Spacer().frame(height: 5.0)
                    
                    HStack {
                        Text("Welcome {{user}} 👋")
                        Spacer()
                    }
                    
                    Spacer().frame(height: 25.0)
                    
                    if let currentProgram = viewModel.currentProgram {
                        
                        HStack {
                            Text("Continue")
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        
                        NavigationLink(destination: ProgramDetailView(program: currentProgram)) {
                            HStack {
                                CellView(program: currentProgram)
                                    .frame(width: 300, height: 250)
                                Spacer()
                            }
                        }
                    }
                    
                    Spacer().frame(height: 25)
                    
                    HStack {
                        Text("Programs")
                            .fontWeight(.heavy)
                        Spacer()
                    }
                    
                    Text("Created to help you improve your racquet skills and prepare for new challenges.").italic()
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewModel.programs, id: \.programName) { program in
                                CellView(program: program)
                                    .frame(width: 200, height: 150)
                            }
                        }
                    }
                    
                    Spacer().frame(height: 25)
                    
                    HStack {
                        Text("Workouts")
                            .fontWeight(.heavy)
                        Spacer()
                    }
                    
                    ForEach(viewModel.getDrillsForToday().prefix(5), id: \.id) { drill in
                        WorkoutMiniView(drill: drill)
                    }
                    
                    Spacer()
                    
                }.padding()
                    .background(Color.clear)
            }
        }
    }
}

struct CellView: View {
    let program: Program
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("racquetball_program")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
            
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                startPoint: .bottom,
                endPoint: .top
            )
            .frame(height: 80)
            .frame(maxWidth: .infinity, alignment: .bottom)
            .clipped()
            
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
        HStack {
            Image("racquetball_man")
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text(drill.title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(drill.description)
                    .font(.footnote)
                    .lineLimit(1)
            }
            Spacer()
        }
    }
}

#Preview {
    DashboardView(viewModel: DashboardViewModel())
}
