//
//  DrillDetailView.swift
//  ElevenTen
//
//  Created by Jorge Romo on 26/04/24.
//

import SwiftUI
import AVKit

struct DrillDetailView: View {
    let drill: Drill
    
    var body: some View {
        VStack(alignment: .leading) {
            if drill.type == "lista_videos" {
                ForEach(drill.videos ?? [], id: \.title) { video in
                    NavigationLink(destination: VideoPlayerView(videoURL: video.videoUrl, videoTitle: video.title)) {
                        Text(video.title)
                            .font(.headline)
                    }
                    .navigationBarTitle(Text(drill.title), displayMode: .inline)
                }
            } else if drill.type == "descripcion_video" {
                VideoPlayerView(videoURL: drill.videoUrl ?? "", videoTitle: drill.title, videoDescription: drill.description)
            } else if drill.type == "titulo_descripcion_imagen" {
                DrillWithImageDetailView(drill: drill)
            }
        }
        .padding()
    }
}

struct DrillWithImageDetailView: View {
    let drill: Drill
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(drill.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    
                    Text(drill.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal) // Agregamos padding horizontal al texto
                
                
                if let imageName = drill.imageUrl {
                    Image(imageName)
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .frame(height: 350)
                }
                
          
                    
                if let videoPath = Bundle.main.path(forResource: drill.videoUrl, ofType: "mp4") {
                    let videoURL = URL(fileURLWithPath: videoPath)
                    VideoPlayer(player: AVPlayer(url: videoURL))
                        .frame(height: 350)
                }
            }
            .padding()
        }
        .navigationBarTitle(Text(drill.title), displayMode: .inline)
    }
}





struct VideoPlayerView: View {
    var videoURL: String
    var videoTitle: String
    var videoDescription: String?
    
    var body: some View {
        VStack{
            Text(videoDescription ?? "")
            if let videoPath = Bundle.main.path(forResource: videoURL, ofType: "mp4") {
                let videoURL = URL(fileURLWithPath: videoPath)
                VideoPlayer(player: AVPlayer(url: videoURL))
                    .frame(height: 350)
            }
        }
        .navigationBarTitle(Text(videoTitle), displayMode: .inline)
    }
}
