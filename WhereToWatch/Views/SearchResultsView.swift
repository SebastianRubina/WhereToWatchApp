//
//  SearchResultsView.swift
//  WhereToWatch
//
//  Created by Sebastián Rubina on 2024-08-25.
//

import SwiftUI

struct SearchResultsView: View {
    @Environment(MoviesViewModel.self) var moviesViewModel
    var query: String
    var body: some View {
        List(moviesViewModel.showsToDisplay) { show in
            ShowCardView(show: show, showDetailedCard: true)
        }
        .listStyle(.plain)
        .navigationTitle("Search Results")
        .navigationBarTitleDisplayMode(.large)
        .task {
            moviesViewModel.showsToDisplay = []
            if !query.isEmpty {
                await moviesViewModel.fetchShowsFromTitle(title: query)
            }
        }
    }
}

#Preview {
    SearchResultsView(query: "Iron Man")
        .environment(MoviesViewModel())
        .task {
            await MoviesViewModel().fetchTopShows()
        }
}
