//
//  MovieService.swift
//  WhereToWatch
//
//  Created by Sebastián Rubina on 2024-08-25.
//

import Foundation
import SwiftUI

struct MovieService {
    let apiKey = Bundle.main.infoDictionary?["SA_API_KEY"] as? String
    let baseUrl = "https://streaming-availability.p.rapidapi.com"
    
    @AppStorage("selectedCountry") var selectedCountry = "us"
    @AppStorage("selectedPlatform") var selectedPlatform: String = "netflix"
    
    func getTopShows() async -> [Show] {
        guard let apiKey else { return [Show]() }
        
        if let url = URL(string: "\(baseUrl)/shows/top?country=\(selectedCountry.lowercased())&service=\(selectedPlatform)") {
            var request = URLRequest(url: url)
            request.addValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                
                let decoder = JSONDecoder()
                let shows = try decoder.decode([Show].self, from: data)
                
                return shows
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        }
        
        return [Show]()
    }
    
    func searchShowsByTitle(title: String) async -> [Show] {
        guard let apiKey else { return [Show]() }
        
        if let url = URL(string: "\(baseUrl)/shows/search/title?country=\(selectedCountry.lowercased())&title=\(title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") {
            var request = URLRequest(url: url)
            request.addValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                
                let decoder = JSONDecoder()
                var shows = try decoder.decode([Show].self, from: data)
                
                shows.sort {
                    if let releaseYear1 = $0.releaseYear, let releaseYear2 = $1.releaseYear {
                        return releaseYear1 > releaseYear2 || (releaseYear1 == releaseYear2 && $0.rating > $1.rating)
                    } else if $0.releaseYear != nil {
                        return true
                    } else if $1.releaseYear != nil {
                        return false
                    } else {
                        return $0.rating > $1.rating
                    }
                }
                return shows
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        }
        
        return [Show]()
    }
}
