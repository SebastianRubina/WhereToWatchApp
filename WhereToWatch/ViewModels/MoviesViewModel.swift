//
//  MoviesViewModel.swift
//  WhereToWatch
//
//  Created by Sebastián Rubina on 2024-08-25.
//

import Foundation

@Observable
class MoviesViewModel {
    let movieService = MovieService()
    
    var showsToDisplay = [Show]()
    var selectedShow: Show?
    
    func fetchTopShows() async {
        showsToDisplay = await movieService.getTopShows()
        
    }
    
    func fetchShowsFromTitle(title: String) async {
        showsToDisplay = await movieService.searchShowsByTitle(title: title)
    }
}
