//
//  ElevenTenApp.swift
//  ElevenTen
//
//  Created by César Venzor on 20/02/24.
//

import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // MARK: - UINavigationBarAppearance
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = UIColor.black
        navAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        UINavigationBar.appearance().compactAppearance = navAppearance
        UINavigationBar.appearance().tintColor = UIColor.white

        // MARK: - UITabBarAppearance
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = UIColor.black

        tabAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(red: 189/255, green: 53/255, blue: 40/255, alpha: 1)
        tabAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(red: 189/255, green: 53/255, blue: 40/255, alpha: 1)]

        tabAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.lightGray
        tabAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]

        UITabBar.appearance().standardAppearance = tabAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabAppearance

        return true
    }
}

@main
struct ElevenTenApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase

    @ObservedObject var store: Store = Store()

    var body: some Scene {
        WindowGroup {
            MainView(store: store)
                .task(id: scenePhase) {
                    if scenePhase == .active {
                        await store.fetchActiveTransactions()
                    }
                }
                .accentColor(Color(red: 189/255, green: 53/255, blue: 40/255)) // Color principal de marca
        }
    }
}
