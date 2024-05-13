//
//  ElevenTenApp.swift
//  ElevenTen
//
//  Created by César Venzor on 20/02/24.
//

import SwiftUI


class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Cambia el color de fondo de toda la barra de navegación
        UINavigationBar.appearance().barTintColor = UIColor.black
        
        return true
    }
}


@main
struct ElevenTenApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            MainView()

                .accentColor(Color(red: 189.0/255.0, green: 53.0/255.0, blue: 40.0/255.0))
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarColor(backgroundColor: Color.black, tintColor: Color(red: 189.0/255.0, green: 53.0/255.0, blue: 40.0/255.0))
        }
    }
}
