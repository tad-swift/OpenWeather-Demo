//
//  GeocoderQuery.swift
//  OpenWeather Demo
//
//  Created by Tadreik Campbell on 6/2/23.
//

import Foundation

// http://api.openweathermap.org/geo/1.0/reverse?lat={lat}&lon={lon}&limit={limit}&appid={API key}

final class GeocoderQuery {
    
    let host = "api.openweathermap.org"
    private(set) var path = "/geo/1.0/direct"
    
    var reverse = false
    var names: [String] = []
    var location: (lat: Double, lon: Double)?
    
    var finalURL: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = []
        if let location, reverse {
            components.queryItems?.append(URLQueryItem(name: "lat", value: String(location.lat)))
            components.queryItems?.append(URLQueryItem(name: "lon", value: String(location.lon)))
        } else {
            let query = names
                .compactMap { $0 }
                .joined(separator: ",")
//                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            components.queryItems?.append(URLQueryItem(name: "q", value: query))
        }
        components.queryItems?.append(URLQueryItem(name: "appid", value: Constants.APIKEY))
        return components.url
    }
    
    init(names: [String]) {
        self.names = names
    }
    
    init(location: (lat: Double, lon: Double)) {
        self.location = location
        self.path = "/geo/1.0/reverse"
        self.reverse = true
    }
    
}
