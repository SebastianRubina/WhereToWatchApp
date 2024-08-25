//
//  ContentView.swift
//  WhereToWatch
//
//  Created by Sebastián Rubina on 2024-08-25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedPlatform") var selectedPlatform: String = "netflix"
    @AppStorage("selectedCountry") var selectedCountry: String = "us"
    @Environment(MoviesViewModel.self) var moviesViewModel
    
    @State var searchText = ""
    
    var body: some View {
        @Bindable var moviesViewModel = moviesViewModel
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    TextField("Search for a movie or series", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .onAppear {
                            UITextField.appearance().clearButtonMode = .whileEditing
                        }
                    
                    NavigationLink {
                        SearchResultsView(query: searchText)
                    } label: {
                        Text("Go")
                    }
                    .buttonStyle(.borderedProminent)
                    
                }
                .padding(.horizontal)
                
                TopShowPlatformPicker(selectedPlatform: $selectedPlatform)
                
                if moviesViewModel.showsToDisplay.isEmpty {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Nothing to see here 😕")
                            .font(.title)
                        Spacer()
                    }
                    .padding(.top, 36)
                } else {
                    List(moviesViewModel.showsToDisplay) { show in
                        ShowCardView(show: show)
                    }
                    .listStyle(.plain)
                }
                
                Spacer()
                BannerView()
                    .frame(height: 40)
                    .background(Color.black)
            }
            .navigationTitle("\(CountryService.getEmoji(for: selectedCountry)) Top Shows")
            .task {
                await moviesViewModel.fetchTopShows()
            }
            .onChange(of: selectedPlatform) {
                Task {
                    await moviesViewModel.fetchTopShows()
                }
            }
            .sheet(item: $moviesViewModel.selectedShow) { _ in
                ShowDetailsView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(MoviesViewModel())
}
