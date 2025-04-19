import SwiftUI

struct MainView: View {
    @ObservedObject var store: Store

    init(store: Store) {
        // Configuración moderna con UITabBarAppearance (iOS 15+)
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.stackedLayoutAppearance.selected.iconColor = .black
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]

        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }

        self.store = store
    }

    var body: some View {
        TabView {
            DashboardView(viewModel: DashboardViewModel())
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

            AccountView(store: store)
                .tabItem {
                    Label("Mi Cuenta", systemImage: "person.crop.circle")
                }
        }
    }
}
