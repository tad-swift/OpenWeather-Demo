//
//  LocationFetcherTests.swift
//  OpenWeather DemoTests
//
//  Created by Tadreik Campbell on 6/3/23.
//

import XCTest
@testable import OpenWeather_Demo

final class LocationFetcherTests: XCTestCase {
    
    var subject = OpenWeatherLocationFetcher(session: MockURLSession(data: Data()))
    
    // will have to create mock json data for this test
    func testFetchLocations_Success() async {
        let results = await subject.fetchLocations(query: .init(names: ["London"]))
        XCTAssertFalse(results.isEmpty)
    }
    
}
