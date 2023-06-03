//
//  SearchResultsProvider.swift
//  OpenWeather Demo
//
//  Created by Tadreik Campbell on 6/2/23.
//

import Foundation

final class SearchResultsProvider<G: Geocoder, W: WeatherFetcher> {
    
    private(set) var weatherFetcher: W
    private(set) var locationFetcher: G
    
    init(weatherFetcher: W, locationFetcher: G) {
        self.weatherFetcher = weatherFetcher
        self.locationFetcher = locationFetcher
    }
    
    func search(query: String) async -> [SearchResult] {
        let words = query.components(separatedBy: ",")
        let trimmedWords = words.map { $0.trimmingCharacters(in: .whitespaces) }
        let geocoderQuery = GeocoderQuery(names: trimmedWords)
        let locations = await locationFetcher.fetchLocations(query: geocoderQuery)
        var localResults: [SearchResult] = []
        for location in locations {
            let weatherQuery = WeatherQuery(coords: (location.lat, location.lon))
            if let weatherResult = await weatherFetcher.fetchResult(weatherQuery) {
                let result = SearchResult(location: location, weather: weatherResult)
                localResults.append(result)
            }
        }
        return localResults
    }
    
}
