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
        if let searchString = UserDefaults.standard.string(forKey: "previous_search") {
            search(searchString)
        }
    }
    
    func search(_ text: String) {
        UserDefaults.standard.set(text, forKey: "previous_search")
        Task.detached(priority: .utility) { [weak self] in
            guard let self else { return }
            let localResults = await searchResultsProvider.search(query: text)
            await MainActor.run {
                self.results = localResults
                
            }
        }
    }
    
    func getWeather(location: (lat: Double, lon: Double)) {
        Task.detached(priority: .utility) { [weak self] in
            guard let self else { return }
            if let result = await searchResultsProvider.getWeather(location: location) {
                self.results.insert(result, at: 0)
            }
        }
    }
    
}
