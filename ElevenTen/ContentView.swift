//
//  ContentView.swift
//  ElevenTen
//
//  Created by César Venzor on 20/02/24.
//

import SwiftUI

struct ContentView: View {
    let tasks = ["RB-Program-1.0"]
    
    var body: some View {
        VStack {
            Image(systemName: "figure.racquetball")
                .imageScale(.large)
                .foregroundStyle(.red)
            Text("Training")
                .fontWeight(.bold)
            
            List(tasks, id: \.self) { task in
                Text(task)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
