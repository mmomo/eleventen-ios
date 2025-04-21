//
//  NewsDetailView.swift
//  ElevenTen
//
//  Created by Jorge Romo on 20/04/25.
//

import SwiftUI

struct NewsDetailView: View {
    let news: NewsItem

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: news.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: 250)
                .clipped()
                .cornerRadius(10)

                Text(news.title)
                    .font(.title)
                    .bold()

                Text(news.longDescription)
                    .font(.body)
                    .foregroundColor(.primary)

                if let link = news.link, let url = URL(string: link) {
                    ShareLink(item: url) {
                        Label("Compartir noticia", systemImage: "square.and.arrow.up")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.brandButtonBackground)
                            .foregroundColor(.brandButtonText)
                            .cornerRadius(10)
                    }
                } else {
                    ShareLink(item: news.title + "\n\n" + news.longDescription) {
                        Label("Compartir noticia", systemImage: "square.and.arrow.up")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.brandButtonBackground)
                            .foregroundColor(.brandButtonText)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
    }
}
