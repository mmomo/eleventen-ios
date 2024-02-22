//
//  TrainingDetailView.swift
//  ElevenTen
//
//  Created by César Venzor on 22/02/24.
//

import SwiftUI
import AVKit

struct TrainingDetailView: View {
    let videoUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "training1", ofType: "mp4") ?? "")
    
    var body: some View {
            VStack {
                VideoPlayer(player: AVPlayer(url: videoUrl))
                    .frame(height: 320)
                
                Spacer().frame(height: 20)

                HStack {
                    Spacer().frame(width: 16)
                    
                    Text("Training Name")
                        .font(.title)
                    Spacer()
                }
                
                Spacer().frame(height: 20)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum dapibus eget arcu iaculis fermentum. Cras rhoncus ex eget neque suscipit.")
                    .padding()
                
                Spacer()
                
                HStack {
                    Button {
                        print("resources")
                    } label: {
                        Text("Resources")
                    }.buttonStyle(.bordered)
                    
                    Spacer().frame(width: 30)
                    Button {
                        print("stats")
                    } label: {
                        Text("Stats")
                    }.buttonStyle(.bordered)
                }
                
                Spacer()

            }
    }
}

#Preview {
    TrainingDetailView()
}
