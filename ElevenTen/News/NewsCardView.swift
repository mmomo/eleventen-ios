//
//  NewsCardView.swift
//  ElevenTen
//
//  Created by Jorge Romo on 20/04/25.
//

import SwiftUI

struct NewsCardView: View {
    let news: NewsItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: news.imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(height: 180)
            .clipped()
            .cornerRadius(10)

            Text(news.title)
                .font(.headline)

            Text(news.shortDescription)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(2)
        }
        .padding()
        .background(Color.brandListBackground)
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}
