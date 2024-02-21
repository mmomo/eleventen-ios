//
//  MainView.swift
//  ElevenTen
//
//  Created by César Venzor on 20/02/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Training", systemImage: "dumbbell")
                }
            
            Text("Clubs")
                .tabItem {
                    Label("Clubs", systemImage: "house")
                }
            
            Text("Scoreboard")
                .tabItem {
                    Label("Scoreboard", systemImage: "sportscourt")
                }
            
            Text("News")
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            Text("Account")
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle")
                }
        }
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
    }
}

#Preview {
    MainView().menuOrder(.automatic)
}
