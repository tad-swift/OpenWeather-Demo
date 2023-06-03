//
//  GeocoderQuery.swift
//  OpenWeather Demo
//
//  Created by Tadreik Campbell on 6/2/23.
//

import Foundation

final class GeocoderQuery {
    
    let host = "api.openweathermap.org"
    let path = "/geo/1.0/direct"
    
    var names: [String]
    
    var finalURL: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = []
        let query = names
            .compactMap { $0 }
            .joined(separator: ",")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        components.queryItems?.append(URLQueryItem(name: "q", value: query))
        components.queryItems?.append(URLQueryItem(name: "appid", value: Constants.APIKEY))
        return components.url
    }
    
    init(names: [String]) {
        self.names = names
    }
    
}
