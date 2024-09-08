//
//  ProgramsListView.swift
//  ElevenTen
//
//  Created by Jorge Romo on 26/04/24.
//

import SwiftUI

struct ProgramsListView: View {
    @EnvironmentObject var store: Store
    @State private var programs: [Program] = []
    
    var body: some View {
        NavigationView {
            VStack {
                if store.hasActiveSubscription() {
                    Text("Ya tienes pro!")
                } else {
                    Text("Free user")
                }
                
                Spacer().frame(height: 16)
                List(programs, id: \.programName) { program in
                    NavigationLink(destination: ProgramDetailView(program: program)) {
                        VStack(alignment: .leading) {
                            Text(program.programName)
                                .font(.headline)
                            Text("Duración: \(program.duration)")
                            Text("Nivel: \(program.level)")
                        }
                    }
                }
                .onAppear {
                    loadProgramsFromJSON()
                }
                .padding()
            }
            .navigationBarTitle(Text("Programas"), displayMode: .inline)
        }
    }
    
    func loadProgramsFromJSON() {
        if let fileUrl = Bundle.main.url(forResource: "programs", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: fileUrl)
                if let jsonDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                    if let programsArray = jsonDictionary["programs"] as? [[String: Any]] {
                        let decoder = JSONDecoder()
                        self.programs = try decoder.decode([Program].self, from: JSONSerialization.data(withJSONObject: programsArray))
                    }
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("File not found")
        }
    }
}

// Extensiones

extension View {
    func navigationBarColor(backgroundColor: Color, tintColor: Color) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, tintColor: tintColor))
    }
}

struct NavigationBarModifier: ViewModifier {
    var backgroundColor: Color = .clear
    var tintColor: Color = .white

    init(backgroundColor: Color, tintColor: Color) {
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor

        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = UIColor(backgroundColor)
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor(tintColor)]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(tintColor)]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
    }

    func body(content: Content) -> some View {
        content
            .onAppear {
                UINavigationBar.appearance().barTintColor = UIColor(backgroundColor)
                UINavigationBar.appearance().tintColor = UIColor(tintColor)
                UINavigationBar.appearance().isTranslucent = false
            }
    }
}

