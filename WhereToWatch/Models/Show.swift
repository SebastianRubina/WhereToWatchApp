//
//  Show.swift
//  WhereToWatch
//
//  Created by Sebastián Rubina on 2024-08-25.
//

import Foundation

struct Show: Decodable, Identifiable {
    var itemType: String
    var showType: String
    var id: String
    var title: String
    var overview: String
    var releaseYear: Int?
    var firstAirYear: Int?
    var lastAirYear: Int?
    var genres: [Genre]
    var directors: [String]?
    var cast: [String]
    var rating: Int
    var seasonCount: Int?
    var episodeCount: Int?
    var runtime: Int?
    var imageSet: ImageSet
    var streamingOptions: [String: [StreamingOption]]
}

struct Genre: Decodable, Identifiable {
    var id: String
    var name: String
}

struct ImageSet: Decodable {
    var verticalPoster: VerticalImage
    var horizontalPoster: HorizontalImage
}

struct VerticalImage: Decodable {
    var w720: String
}

struct HorizontalImage: Decodable {
    var w720: String
    var w1080: String
}

struct StreamingOption: Decodable, Identifiable {
    let id = UUID()
    var service: StreamingService?
    var type: String?
    var link: String?
    var price: ShowPrice?
}

struct StreamingService: Decodable {
    var id: String?
    var name: String?
    var imageSet: StreamingServiceImageSet?
}

struct StreamingServiceImageSet: Decodable {
    var lightThemeImage: String?
    var darkThemeImage: String?
    var whiteImage: String?
}

struct ShowPrice: Decodable {
    var amount: String?
    var currency: String?
    var formatted: String?
}
