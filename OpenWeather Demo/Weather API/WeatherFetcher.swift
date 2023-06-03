//
//  WeatherFetcher.swift
//  OpenWeather Demo
//
//  Created by Tadreik Campbell on 6/1/23.
//

import Foundation

protocol WeatherFetcher: AnyObject {
    var session: URLSession { get set }
    func fetchResult(_ query: WeatherQuery) async -> WeatherModel?
}

final class OpenWeatherFetcher: WeatherFetcher {
    
    var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchResult(_ query: WeatherQuery) async -> WeatherModel? {
        guard let url = query.finalURL else { return nil }
        let request = URLRequest(url: url)
        guard let (data, _) = try? await session.data(for: request) else {
            return nil
        }
        do {
            let result = try JSONDecoder().decode(WeatherModel.self, from: data)
            return result
        } catch {
            print(error)
        }
        return nil
    }
}
