import SwiftUI
import AVKit

struct DrillDetailView: View {
    let drill: Drill

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Title & Description Card
                VStack(alignment: .leading, spacing: 12) {
                    Text(drill.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.brandText)

                    if let description = drill.description {
                        Text(description)
                            .font(.body)
                            .foregroundColor(.brandSecondaryText)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.brandListBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                .padding(.horizontal)

                // Image Card
                if let imageName = drill.imageUrl {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                        .clipped()
                        .cornerRadius(16)
                        .padding(.horizontal)
                }

                // Video Card
                if let videoUrl = drill.videoUrl, let path = Bundle.main.path(forResource: videoUrl, ofType: "mp4") {
                    let url = URL(fileURLWithPath: path)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Video de ejemplo")
                            .font(.headline)
                            .foregroundColor(.brandText)

                        VideoPlayer(player: AVPlayer(url: url))
                            .frame(height: 250)
                            .cornerRadius(16)
                    }
                    .padding()
                    .background(Color.brandListBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                    .padding(.horizontal)
                }

                // Lista de videos (tipo lista_videos)
                if drill.type == "lista_videos" {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(drill.videos ?? [], id: \.title) { video in
                            NavigationLink(destination: VideoPlayerView(videoURL: video.videoUrl, videoTitle: video.title)) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Image("racquetball_man")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 100)
                                        .frame(maxWidth: .infinity)
                                        .clipped()
                                        .cornerRadius(12)

                                    Text(video.title)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(.brandText)
                                        .lineLimit(2)
                                }
                                .padding()
                                .background(Color.brandListBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer(minLength: 40)
            }
            .padding(.vertical)
        }
        .background(Color.brandBackground.ignoresSafeArea())
        .navigationTitle(drill.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct VideoPlayerView: View {
    var videoURL: String
    var videoTitle: String
    var videoDescription: String?

    var body: some View {
        VStack(spacing: 20) {
            if let description = videoDescription {
                Text(description)
                    .font(.body)
                    .foregroundColor(.brandSecondaryText)
                    .padding(.horizontal)
            }

            if let path = Bundle.main.path(forResource: videoURL, ofType: "mp4") {
                let url = URL(fileURLWithPath: path)
                VideoPlayer(player: AVPlayer(url: url))
                    .frame(height: 250)
                    .cornerRadius(16)
            }
        }
        .navigationTitle(videoTitle)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.brandBackground.ignoresSafeArea())
    }
}
