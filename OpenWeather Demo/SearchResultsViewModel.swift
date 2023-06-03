//
//  SearchResultsViewModel.swift
//  OpenWeather Demo
//
//  Created by Tadreik Campbell on 6/2/23.
//

import Foundation

final class SearchResultsViewModel<G: Geocoder, W: WeatherFetcher>: ObservableObject {
    
    private(set) var searchResultsProvider: SearchResultsProvider<G, W>
    
    @Published var results: [SearchResult] = []
    
    init(searchResultsProvider: SearchResultsProvider<G, W> = SearchResultsProvider(weatherFetcher: OpenWeatherFetcher(), locationFetcher: OpenWeatherLocationFetcher())) {
        self.searchResultsProvider = searchResultsProvider
    }
    
    func search(_ text: String) {
        Task.detached(priority: .utility) { [weak self] in
            guard let self else { return }
            let localResults = await searchResultsProvider.search(query: text)
            await MainActor.run {
                self.results = localResults
            }
        }
    }
    
}
