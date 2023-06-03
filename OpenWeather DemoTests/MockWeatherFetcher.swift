//
//  MockWeatherFetcher.swift
//  OpenWeather DemoTests
//
//  Created by Tadreik Campbell on 6/3/23.
//

import Foundation
@testable import OpenWeather_Demo

class MockWeatherFetcher: WeatherFetcher {
    
    var session: URLSession
    
    var shouldReturnNil = false
    
    init(session: URLSession = MockURLSession(data: Data())) {
        self.session = session
    }
    
    func fetchResult(_ query: WeatherQuery) async -> WeatherModel? {
        shouldReturnNil ? nil : WeatherModel(coord: .init(lon: 0, lat: 0), weather: nil, base: nil, main: nil, visibility: 0, wind: nil, rain: nil, clouds: nil, dt: 0, sys: nil, timezone: 0, id: 0, name: nil, cod: 0)
    }
    
}
