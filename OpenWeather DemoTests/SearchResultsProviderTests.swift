//
//  SearchResultsProviderTests.swift
//  OpenWeather DemoTests
//
//  Created by Tadreik Campbell on 6/3/23.
//

import XCTest
@testable import OpenWeather_Demo

final class SearchResultsProviderTests: XCTestCase {
    
    var subject: SearchResultsProvider<MockLocationFetcher, MockWeatherFetcher>!

    override func setUpWithError() throws {
        subject = SearchResultsProvider(weatherFetcher: MockWeatherFetcher(), locationFetcher: MockLocationFetcher())
    }

    override func tearDownWithError() throws {
        
    }
    
    func testSearch_Success() async {
        let results = await subject.search(query: "Lodon")
        XCTAssertFalse(results.isEmpty)
    }
    
    func testSearch_emptyWhenLocationQueryFails() async {
        (subject.locationFetcher as MockLocationFetcher).shouldReturnEmpty = true
        let results = await subject.search(query: "Lodon")
        XCTAssertTrue(results.isEmpty)
    }
    
    func testSearch_emptyWhenWeatherQueryFails() async {
        (subject.weatherFetcher as MockWeatherFetcher).shouldReturnNil = true
        let results = await subject.search(query: "Lodon")
        XCTAssertTrue(results.isEmpty)
    }

}
