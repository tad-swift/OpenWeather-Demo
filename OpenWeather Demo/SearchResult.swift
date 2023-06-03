//
//  SearchResult.swift
//  OpenWeather Demo
//
//  Created by Tadreik Campbell on 6/3/23.
//

import Foundation

struct SearchResult: Identifiable {
    let location: GeocodeModel
    let weather: WeatherModel
    
    var id: String {
        "\(location.id)\(weather.id ?? 0)"
    }
}
