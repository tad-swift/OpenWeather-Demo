//
//  LocationFetcher.swift
//  OpenWeather Demo
//
//  Created by Tadreik Campbell on 6/2/23.
//

import Foundation

protocol Geocoder: AnyObject {
    var session: URLSession { get set }
    func fetchLocations(query: GeocoderQuery) async -> [GeocodeModel]
}

final class OpenWeatherLocationFetcher: Geocoder {
    
    var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    func fetchLocations(query: GeocoderQuery) async -> [GeocodeModel] {
        guard let url = query.finalURL else { return [] }
        let request = URLRequest(url: url)
        // this can be wrapped in a do-catch | retry after failures
        guard let (data, _) = try? await URLSession.shared.data(for: request) else {
            return []
        }
        do {
            let results = try JSONDecoder().decode([GeocodeModel].self, from: data)
            return results
        } catch {
            print(error)
        }
        return []
    }
}
