//
//  ShowDetailsView.swift
//  WhereToWatch
//
//  Created by Sebastián Rubina on 2024-08-25.
//

import SwiftUI

struct ShowDetailsView: View {
    @Environment(MoviesViewModel.self) var moviesViewModel
    @AppStorage("selectedCountry") var selectedCountry = "us"
    var body: some View {
        @State var show = moviesViewModel.selectedShow
        VStack {
            if let url = URL(string: show?.imageSet.horizontalPoster.w1080 ?? "") {
                if show!.imageSet.horizontalPoster.w1080.contains("svg") {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.gray)
                            .opacity(0.5)
                        Text(show!.title)
                            .font(.title)
                    }
                    .frame(height: 200)
                } else {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                            .frame(height: 300)
                    }
                }
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Text(show?.title ?? "Show Title")
                            .font(.title2)
                            .bold()
                            .padding(.vertical, 10)
                        
                        Spacer()
                        
                        HStack {
                            Text(show?.showType.capitalized ?? "Movie")
                            Image(systemName: show?.showType == "series" ? "tv" : "popcorn")
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Show Information")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        VStack(alignment: .leading) {
                            if let rating = show?.rating, rating > 0 {
                                HStack {
                                    Text("Rating")
                                        .bold()
                                    Spacer()
                                    Text("\(rating)")
                                    Image(systemName: "trophy")
                                }
                                .foregroundStyle(ColorHelpers.getScoreColor(score: Double(rating)))

                                Divider()
                                    .padding(.vertical, 5)
                            }
                            
                            if let releaseYear = show?.releaseYear {
                                HStack {
                                    Text("Release Year")
                                        .bold()
                                    Spacer()
                                    Text("\(releaseYear)")
                                    Image(systemName: "calendar")
                                }
                                Divider()
                                    .padding(.vertical, 5)
                            }
                            
                            if let firstAirYear = show?.firstAirYear {
                                HStack {
                                    Text("First Aired")
                                        .bold()
                                    Spacer()
                                    Text("\(firstAirYear)")
                                    Image(systemName: "calendar")
                                }
                                Divider()
                                    .padding(.vertical, 5)
                            }
                            
                            if let lastAirYear = show?.lastAirYear {
                                HStack {
                                    Text("Last Aired")
                                        .bold()
                                    Spacer()
                                    Text("\(lastAirYear)")
                                    Image(systemName: "number")
                                }
                                Divider()
                                    .padding(.vertical, 5)
                            }
                            
                            if let seasonCount = show?.seasonCount {
                                HStack {
                                    Text("Season Count")
                                        .bold()
                                    Spacer()
                                    Text("\(seasonCount)")
                                    Image(systemName: "number")
                                }
                                Divider()
                                    .padding(.vertical, 5)
                            }
                            
                            if let episodeCount = show?.episodeCount {
                                HStack {
                                    Text("Episode Count")
                                        .bold()
                                    Spacer()
                                    Text("\(episodeCount)")
                                    Image(systemName: "movieclapper")
                                }
                            }
                            
                            if let runtime = show?.runtime {
                                HStack {
                                    Text("Runtime")
                                        .bold()
                                    Spacer()
                                    Text("\(runtime) minutes")
                                    Image(systemName: "clock")
                                }
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .clipShape(.rect(cornerRadius: 10))
                        
                    }
                    .padding(.vertical)
                    
                    if let streamingOptions = show?.streamingOptions[selectedCountry] {
                        VStack(alignment: .leading) {
                            Text("Where to Watch")
                                .font(.headline)
                                .padding(.bottom, 5)
                            
                            VStack(alignment: .leading) {
                                ForEach(streamingOptions) {streamingOption in
                                    HStack {
                                        Text(streamingOption.service?.name ?? "Service")
                                            .bold()
                                        Text("(\(streamingOption.type?.capitalized ?? "Type"))")
                                        
                                        Spacer()
                                        
                                        
                                        Spacer()
                                        
                                        if let url = URL(string: streamingOption.link ?? "") {
                                            Link(streamingOption.price != nil ? "$\(streamingOption.price!.formatted!)" : "Watch", destination: url)
                                                .buttonStyle(.borderedProminent)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .clipShape(.rect(cornerRadius: 10))
                        }
                        .padding(.vertical)
                    }
                    
                    if let directors = show?.directors, directors.count > 0 {
                        VStack(alignment: .leading) {
                            Text("Directors")
                                .font(.headline)
                                .padding(.bottom, 5)
                            
                            VStack(alignment: .leading) {
                                
                                ForEach(Array(directors.enumerated()), id: \.offset) { index, director in
                                    HStack {
                                        Image(systemName: "person")
                                        Text("\(director)")
                                        
                                        Spacer()
                                    }
                                    
                                    if index < directors.count - 1 {
                                        Divider()
                                    }
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .clipShape(.rect(cornerRadius: 10))
                            
                        }
                        .padding(.vertical)
                    }
                    
                    if let cast = show?.cast, cast.count > 0 {
                        VStack(alignment: .leading) {
                            Text("Cast")
                                .font(.headline)
                                .padding(.bottom, 5)
                            
                            VStack(alignment: .leading) {
                                
                                ForEach(Array((show?.cast.enumerated())!), id: \.offset) { index, member in
                                    HStack {
                                        Image(systemName: "person")
                                        Text("\(member)")
                                        
                                        Spacer()
                                    }
                                    
                                    if index < cast.count - 1 {
                                        Divider()
                                    }
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .clipShape(.rect(cornerRadius: 10))
                            
                        }
                        .padding(.vertical)
                    }
                    
                    if let overview = show?.overview, !overview.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Overview")
                                .font(.headline)
                                .padding(.bottom, 5)
                            
                            VStack(alignment: .leading) {
                                Text(overview)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .clipShape(.rect(cornerRadius: 10))
                        }
                        .padding(.vertical)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ShowDetailsView()
        .environment(MoviesViewModel())
        .onAppear {
            MoviesViewModel().selectedShow = Show(itemType: "show", showType: "series", id: "123", title: "Dirty Pop: The Boy Band Scam", overview: "", releaseYear: nil, firstAirYear: Optional(2024), lastAirYear: Optional(2024), genres: [Genre(id: "crime", name: "Crime"), Genre(id: "documentary", name: "Documentary")], directors: nil, cast: [], rating: 0, seasonCount: Optional(1), episodeCount: Optional(3), runtime: nil, imageSet: ImageSet(verticalPoster: VerticalImage(w720: "https://cdn.movieofthenight.com/show/9883845/poster/vertical/en/720.jpg?Expires=1753585287&Signature=kUlZuDijR~UcKPx0ksO7x9C~QU6hjjti9MVzFLPn9ap2eA2VWfu7Ck6IklGqWTYwz7IQ44cDkyCNazplws0AMUP0T98ZfLNx0vmHUfss8BDwFqksjOhZNYCITkyL~kK~kZXq7TOmPGhQc3Byxwtl-TvkweYu~vzyPkc6LK09W2QCzEoMDjwcxset9T99zpUh95~QF7JNO2Ue9ZzE1oF7pAltHoEFEqIVPZY97Tt0ApgL--UCDDiO1PRKmIIrIaMxByPf5JnUzA0MijRgPnKCOT~Zq39zoQyufi3BvW0DBAIMz0eETfhQ~CC9ITJfFkOvCLUWkQPiMJ10G4V6GjkR3w__&Key-Pair-Id=KK4HN3OO4AT5R"), horizontalPoster: HorizontalImage(w720: "https://cdn.movieofthenight.com/show/9883845/poster/horizontal/en/720.jpg?Expires=1753585292&Signature=df8nu0Cqf~nNNN-9fXnoFKxhSgvra0U-zz0U3XPcBQER2V-wAO7xwFEN4xNdKrYCknBQ99Djft6bWhPq5uLwdjG61yrb0svzmoaAnRPjau53SCHdhuHEHPXecW6BTC3oJGmyc0h5~aO2yTXCD5Dz41yDeDGOjn-lHLwTTC-zh0MCG-NSSlP5eMlWEqZiDG87kjo5LKfZcf~oDGRy929pqYk3ZhieXQkqzAQ7tzcBGUyXoNxNnofaL~hBTSLgT795vWClDGE4nmVtYdw09I66Ne6tjtbKZjLf0~S72dHWLwFDU4AtvLqPHkuIhSQuFko8Ao70V3poC7bs~Em6~Pgx5w__&Key-Pair-Id=KK4HN3OO4AT5R", w1080: "https://cdn.movieofthenight.com/show/9883845/poster/horizontal/en/1080.jpg?Expires=1753585292&Signature=YyyzednoWwPI6aaIZqy4EdEPExVgyNcFz3bC1NCEu8Q9E~MYNLAqL2V8~U5gkQuqiCRik4WlhmhYsd2D9zmKJWp46jaOUMV4xq5DAglCIHCrEW~J~nQjByNsb923wCkwKNAQrSR6N0vReXLDVUSg5mfp3UUXFhaF-SLqrEpo7y2oGJXr9BJb6~pV4o0HXbTA0xacdLw4eX5U5jCYBI1W6qwQAFvCAmysKDiy~JUMiFvf9oS6RXVF4q6B21k62IvmJEfVOfrXoiv~Gor2Pvp6NSHLjcTPubKpvBvPeNhx7xq3GJevH6hfnZB7hW7EJGOxJsB78bsDPcKvWEmiw~mDUA__&Key-Pair-Id=KK4HN3OO4AT5R")), streamingOptions: ["us": [StreamingOption(service: Optional(StreamingService(id: Optional("netflix"), name: Optional("Netflix"), imageSet: Optional(StreamingServiceImageSet(lightThemeImage: Optional("https://media.movieofthenight.com/services/netflix/logo-light-theme.svg"), darkThemeImage: Optional("https://media.movieofthenight.com/services/netflix/logo-dark-theme.svg"), whiteImage: Optional("https://media.movieofthenight.com/services/netflix/logo-white.svg"))))), type: Optional("subscription"), link: Optional("https://www.netflix.com/title/81476403/"), price: nil)]])
        }
}

