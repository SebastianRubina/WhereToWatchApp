//
//  ShowCardView.swift
//  WhereToWatch
//
//  Created by Sebastián Rubina on 2024-08-25.
//

import SwiftUI

struct ShowCardView: View {
    @Environment(MoviesViewModel.self) var moviesViewModel
    @AppStorage("selectedCountry") var selectedCountry: String = "us"
    var show: Show
    var showDetailedCard: Bool = false
    
    var body: some View {
        ZStack {
            if let url = URL(string: show.imageSet.horizontalPoster.w1080) {
                if show.imageSet.horizontalPoster.w1080.contains("svg") {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.gray)
                            .opacity(0.5)
                        Text(show.title)
                            .font(.title)
                    }
                    .frame(height: 200)
                } else {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 10))
                    } placeholder: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.gray)
                                .opacity(0.5)
                            ProgressView()
                        }
                        .frame(height: 200)
                    }
                }
            }
            
            VStack {
                Spacer()
                
                Rectangle()
                    .fill(.clear)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.clear, .black, .black]), startPoint: .top, endPoint: .bottom)
                    )
                    .opacity(0.9)
                    .frame(height: 100)
            }
            
            VStack {
                Rectangle()
                    .fill(.clear)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .bottom)
                    )
                    .opacity(0.8)
                    .frame(height: 100)
                
                Spacer()
            }
            
            VStack {
                HStack {
                    Text(show.title)
                        .font(.headline)
                    
                    
                    Spacer()
                    
                    if show.rating > 0 {
                        HStack {
                            Image(systemName: "trophy.fill")
                                .foregroundStyle(ColorHelpers.getScoreColor(score: Double(show.rating)))
                            Text("\(show.rating)")
                                .bold()
                                .foregroundStyle(ColorHelpers.getScoreColor(score: Double(show.rating)))
                        }
                    }
                }
                
                Spacer()
                
                if showDetailedCard == true {
                    HStack {
                        let uniqueServiceNames = Set(show.streamingOptions[selectedCountry]?.compactMap { $0.service?.name } ?? []).sorted { $0 < $1 }
                        
                        ForEach(Array(uniqueServiceNames), id: \.self) { serviceName in
                            Text(serviceName)
                                .bold()
                                .padding(.horizontal, 8)
                                .padding(.vertical, 2)
                                .background(Color.white.opacity(0.8)) // Set your desired background color here
                                .foregroundColor(.black) // Set the text color
                                .cornerRadius(15)
                        }
                    }
                }
                
                HStack {
                    HStack(alignment: .center) {
                        Image(systemName: show.showType == "series" ? "tv" : "popcorn")
                        Text("\(show.showType.capitalized)")
                    }
                    
                    Spacer()
                    
                    if let releaseYear = show.releaseYear {
                        HStack(alignment: .center) {
                            Image(systemName: "calendar")
                            Text("\(releaseYear)".replacingOccurrences(of: ",", with: ""))
                        }
                    }
                    
                    Spacer()
                    
                    HStack(alignment: .center) {
                        Text(show.genres.first?.name ?? "Genre")
                        Image(systemName: "info.circle")
                    }
                }
                
            }
            .padding()
            .frame(maxHeight: 300)
        }
        .onTapGesture {
            moviesViewModel.selectedShow = show
        }
    }
}

#Preview {
    ShowCardView(show: Show(itemType: "show", showType: "series", id: "123", title: "Dirty Pop: The Boy Band Scam", overview: "", releaseYear: nil, firstAirYear: Optional(2024), lastAirYear: Optional(2024), genres: [Genre(id: "crime", name: "Crime"), Genre(id: "documentary", name: "Documentary")], directors: nil, cast: [], rating: 0, seasonCount: Optional(1), episodeCount: Optional(3), runtime: nil, imageSet: ImageSet(verticalPoster: VerticalImage(w720: "https://cdn.movieofthenight.com/show/9883845/poster/vertical/en/720.jpg?Expires=1753585287&Signature=kUlZuDijR~UcKPx0ksO7x9C~QU6hjjti9MVzFLPn9ap2eA2VWfu7Ck6IklGqWTYwz7IQ44cDkyCNazplws0AMUP0T98ZfLNx0vmHUfss8BDwFqksjOhZNYCITkyL~kK~kZXq7TOmPGhQc3Byxwtl-TvkweYu~vzyPkc6LK09W2QCzEoMDjwcxset9T99zpUh95~QF7JNO2Ue9ZzE1oF7pAltHoEFEqIVPZY97Tt0ApgL--UCDDiO1PRKmIIrIaMxByPf5JnUzA0MijRgPnKCOT~Zq39zoQyufi3BvW0DBAIMz0eETfhQ~CC9ITJfFkOvCLUWkQPiMJ10G4V6GjkR3w__&Key-Pair-Id=KK4HN3OO4AT5R"), horizontalPoster: HorizontalImage(w720: "https://cdn.movieofthenight.com/show/9883845/poster/horizontal/en/720.jpg?Expires=1753585292&Signature=df8nu0Cqf~nNNN-9fXnoFKxhSgvra0U-zz0U3XPcBQER2V-wAO7xwFEN4xNdKrYCknBQ99Djft6bWhPq5uLwdjG61yrb0svzmoaAnRPjau53SCHdhuHEHPXecW6BTC3oJGmyc0h5~aO2yTXCD5Dz41yDeDGOjn-lHLwTTC-zh0MCG-NSSlP5eMlWEqZiDG87kjo5LKfZcf~oDGRy929pqYk3ZhieXQkqzAQ7tzcBGUyXoNxNnofaL~hBTSLgT795vWClDGE4nmVtYdw09I66Ne6tjtbKZjLf0~S72dHWLwFDU4AtvLqPHkuIhSQuFko8Ao70V3poC7bs~Em6~Pgx5w__&Key-Pair-Id=KK4HN3OO4AT5R", w1080: "https://cdn.movieofthenight.com/show/9883845/poster/horizontal/en/1080.jpg?Expires=1753585292&Signature=YyyzednoWwPI6aaIZqy4EdEPExVgyNcFz3bC1NCEu8Q9E~MYNLAqL2V8~U5gkQuqiCRik4WlhmhYsd2D9zmKJWp46jaOUMV4xq5DAglCIHCrEW~J~nQjByNsb923wCkwKNAQrSR6N0vReXLDVUSg5mfp3UUXFhaF-SLqrEpo7y2oGJXr9BJb6~pV4o0HXbTA0xacdLw4eX5U5jCYBI1W6qwQAFvCAmysKDiy~JUMiFvf9oS6RXVF4q6B21k62IvmJEfVOfrXoiv~Gor2Pvp6NSHLjcTPubKpvBvPeNhx7xq3GJevH6hfnZB7hW7EJGOxJsB78bsDPcKvWEmiw~mDUA__&Key-Pair-Id=KK4HN3OO4AT5R")), streamingOptions: ["us": [StreamingOption(service: Optional(StreamingService(id: Optional("netflix"), name: Optional("Netflix"), imageSet: Optional(StreamingServiceImageSet(lightThemeImage: Optional("https://media.movieofthenight.com/services/netflix/logo-light-theme.svg"), darkThemeImage: Optional("https://media.movieofthenight.com/services/netflix/logo-dark-theme.svg"), whiteImage: Optional("https://media.movieofthenight.com/services/netflix/logo-white.svg"))))), type: Optional("subscription"), link: Optional("https://www.netflix.com/title/81476403/"), price: nil)]]), showDetailedCard: true)
        .environment(MoviesViewModel())
}
