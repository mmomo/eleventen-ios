import SwiftUI
import StoreKit

struct AccountView: View {
    @ObservedObject var store: Store
    @State private var showLogin = false
    @State private var showRegister = false // 👈 Para mostrar el registro

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                // Botón de iniciar sesión
                Button(action: {
                    showLogin = true
                }) {
                    Text("Iniciar sesión")
                        .font(.headline)
                        .foregroundColor(.brandButtonText)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.brandButtonBackground)
                        .cornerRadius(10)
                }

                // Botón de registro 👇
                Button(action: {
                    showRegister = true
                }) {
                    Text("Crear cuenta")
                        .font(.headline)
                        .foregroundColor(.brandButtonText)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.brandButtonBackground)
                        .cornerRadius(10)
                }

                if store.hasActiveSubscription() {
                    Text("Pro user")
                        .font(.title2)
                        .padding(.top, 10)
                } else {
                    Text("Free user")
                        .font(.title2)
                        .padding(.top, 10)
                }

                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)

                Spacer()

                StoreView(ids: store.subscriptionIDs.values)
                    .productViewStyle(.compact)
                    .storeButton(.visible, for: .restorePurchases)
            }
            .padding()
            .navigationBarTitle(Text("Cuenta"), displayMode: .inline)
        }
        .sheet(isPresented: $showLogin) {
            LoginView()
        }
        .sheet(isPresented: $showRegister) {
            RegisterView() // 👈 Vista de registro modal
        }
        .task {
            await store.fetchSubscriptions()
        }
    }
}

#Preview {
    AccountView(store: Store())
}
