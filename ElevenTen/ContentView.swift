//
//  ContentView.swift
//  ElevenTen
//
//  Created by César Venzor on 20/02/24.
//

import SwiftUI

struct ContentView: View {
    let tasks = ["Task 1", "Task 2", "Task 3", "Task 4", "Task 5"]
    
    var body: some View {
        VStack {
            Image(systemName: "dumbbell")
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
