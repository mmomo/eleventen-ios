//
//  MainView.swift
//  ElevenTen
//
//  Created by César Venzor on 20/02/24.
//

import SwiftUI

struct MainView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }
    var body: some View {
        TabView {
            ProgramsListView()
                .tabItem {
                    Label("Entrenar", systemImage: "figure.racquetball")
                }
            
            ClubsView()
                .tabItem {
                    Label("Clubs", systemImage: "house")
                }
            
            ScoreSettingsView()
                .tabItem {
                    Label("Marcador", systemImage: "sportscourt")
                }
            
            Text("Noticias")
                .tabItem {
                    Label("Noticias", systemImage: "newspaper")
                }
            
            AccountView()
                .tabItem {
                    Label("Mi Cuenta", systemImage: "person.crop.circle")
                }
        }
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
    }
}

#Preview {
    MainView().menuOrder(.automatic)
}
