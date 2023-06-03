//
//  WeatherQueryBuilder.swift
//  OpenWeather Demo
//
//  Created by Tadreik Campbell on 6/1/23.
//

import Foundation

final class WeatherQuery {
    
    let host = "api.openweathermap.org"
    let path = "/data/2.5/weather"
    
    let coords: (lat: Double, lon: Double)
    
    var finalURL: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = []
        components.queryItems?.append(URLQueryItem(name: "lat", value: String(coords.lat)))
        components.queryItems?.append(URLQueryItem(name: "lon", value: String(coords.lon)))
        components.queryItems?.append(URLQueryItem(name: "appid", value: Constants.APIKEY))
        return components.url
    }
    
    init(coords: (Double, Double)) {
        self.coords = coords
    }
    
}
