//
//  WeatherFetcherTests.swift
//  OpenWeather DemoTests
//
//  Created by Tadreik Campbell on 6/3/23.
//

import XCTest
@testable import OpenWeather_Demo

final class WeatherFetcherTests: XCTestCase {
    
    var subject = OpenWeatherFetcher(session: MockURLSession(data: Data()))
    
    func testFetchResult_Success() async {
        let result = await subject.fetchResult(.init(coords: (0, 0)))
        XCTAssertNotNil(result)
    }
    
}
