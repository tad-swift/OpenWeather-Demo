//
//  MockURLSession.swift
//  OpenWeather DemoTests
//
//  Created by Tadreik Campbell on 6/3/23.
//

import Foundation

import Foundation

class MockURLSession: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    private let data: Data?
    
    init(data: Data?) {
        self.data = data
    }
    
    override func dataTask(
        with request: URLRequest,
        completionHandler: @escaping CompletionHandler
    ) -> URLSessionDataTask {
        let task = MockURLSessionDataTask(
            completionHandler: completionHandler,
            data: data
        )
        task.resume()
        return task
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    private let completionHandler: MockURLSession.CompletionHandler
    private let data: Data?
    override var response: URLResponse? {
        .init()
    }
    override var error: Error? {
        NSError(domain: "", code: 0)
    }
    
    init(
        completionHandler: @escaping MockURLSession.CompletionHandler,
        data: Data?
    ) {
        self.completionHandler = completionHandler
        self.data = data
    }
    
    override func resume() {
        DispatchQueue.main.async {
            self.completionHandler(self.data, self.response, self.error)
        }
    }
}

