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
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var store = Store()
    
    var body: some Scene {
        WindowGroup {
            LogInView()
        }
    }
}
