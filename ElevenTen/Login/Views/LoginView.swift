//
//  LoginView.swift
//  ElevenTen
//
//  Created by Jorge Romo on 12/03/25.
//

//
//  LoginView.swift
//  ElevenTen
//
//  Created by Jorge Romo on 12/03/25.
//

import Foundation
import SwiftUI

struct LogInView: View {
    @StateObject private var viewModel = LoginViewModel() // ViewModel agregado
    @State private var isSecured: Bool = true

    var body: some View {
        VStack {
            Image("relaxlogo")
                .resizable()
                .frame(width: 100, height: 100)
            
            Text(LocalizedStringKey("welcome"))
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .foregroundColor(Color(hex: 0x1ACCB5))
            
            TextField(LocalizedStringKey("email"), text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 25)
            
            ZStack(alignment: .trailing) {
                Group {
                    if isSecured {
                        SecureField(LocalizedStringKey("password"), text: $viewModel.password)
                    } else {
                        TextField(LocalizedStringKey("password"), text: $viewModel.password)
                    }
                }
                .padding(.trailing, 32)
                .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    isSecured.toggle()
                }) {
                    Image(systemName: self.isSecured ? "eye.slash" : "eye")
                        .accentColor(.gray)
                }
            }
            .padding(.bottom, 20)
            
            Button(action: {
                viewModel.login() // Llamamos la función de login
            }) {
                Text("button_login")
                    .bold()
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 350, height: 35)
            }
            .background(Color(hex: 0x1ACCB5))
            .clipShape(Capsule())
            .padding(.top)

            if !viewModel.loginMessage.isEmpty {
                Text(viewModel.loginMessage)
                    .foregroundColor(viewModel.isLoggedIn ? .green : .red)
                    .padding()
            }
            
            Button(action: {
                print("Si")
            }) {
                Text(LocalizedStringKey("message_create_account"))
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 350, height: 35)
                    .font(.system(size: 14))
            }
            .background(Color(.white))
            .clipShape(Capsule())
            .padding(.top, 5)
        }
        .padding()
    }
}

extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

#Preview {
    LogInView()
}

