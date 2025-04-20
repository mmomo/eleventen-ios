//
//  NewsListView.swift
//  ElevenTen
//
//  Created by Jorge Romo on 20/04/25.
//
import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel = NewsViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.news) { item in
                        NavigationLink(destination: NewsDetailView(news: item)) {
                            NewsCardView(news: item)
                                .padding(.horizontal)
                        }
                    }

                    if viewModel.isLoading {
                        ProgressView("Cargando noticias...")
                    }

                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Noticias")
        }
        .onAppear {
            viewModel.fetchNews()
        }
    }
}

