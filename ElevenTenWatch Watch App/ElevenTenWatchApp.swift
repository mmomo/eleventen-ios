import SwiftUI

@main
struct ElevenTen_Watch_App: App {
    var body: some Scene {
        WindowGroup {
            WatchScoreView()
                .onOpenURL { url in
                    print("✅ App abierta desde complication con URL: \(url.absoluteString)")
                    // Puedes agregar lógica aquí si en el futuro manejas rutas diferentes
                }
        }
    }
}
