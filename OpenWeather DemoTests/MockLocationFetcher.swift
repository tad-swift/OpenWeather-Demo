//
//  MockLocationFetcher.swift
//  OpenWeather DemoTests
//
//  Created by Tadreik Campbell on 6/3/23.
//

import Foundation
@testable import OpenWeather_Demo

class MockLocationFetcher: Geocoder {
    
    var session: URLSession
    
    var shouldReturnEmpty = false
    
    init(session: URLSession = MockURLSession(data: Data())) {
        self.session = session
    }
    
    func fetchLocations(query: GeocoderQuery) async -> [GeocodeModel] {
        let model = [GeocodeModel(lat: 0, lon: 0)]
        return shouldReturnEmpty ? [] : model
    }
    
}
