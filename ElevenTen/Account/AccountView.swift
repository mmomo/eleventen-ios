//
//  AccountView.swift
//  ElevenTen
//
//  Created by César Venzor on 02/09/24.
//

import SwiftUI
import StoreKit

struct AccountView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationView {
            
            VStack {
                Text("Usuario")
                
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                                
                Spacer()
                StoreView(
                    ids: ["subscription.basic", "subscription.premium"]
                )
                .productViewStyle(.compact)
                .storeButton(.visible, for: .restorePurchases)
            }
            
            .navigationBarTitle(Text("Cuenta"), displayMode: .inline)
        }.task {
            await store.fetchSubscriptions()
        }
    }
}

#Preview {
    AccountView()
}
