//
//  MockURLSession.swift
//  TuitterTests
//
//  Created by Joni Bandoni on 21/04/2024.
//

import Foundation
@testable import Tuitter

final class MockURLSession {
    
    var stubDataForRequestLastResponse: (Data, URLResponse) = (Data(),URLResponse())
    var dataForRequestLastParam: URLRequest? = nil
    var didCallDataForRequestCount = 0
    
    var stubDataFromUrlLastResponse: (Data, URLResponse) = (Data(),URLResponse())
    var dataFromUrlLastParam: URL? = nil
    var didCallDataFromUrlCount = 0

}

extension MockURLSession: URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        didCallDataForRequestCount += 1
        dataForRequestLastParam = request
        return stubDataForRequestLastResponse
    }
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        didCallDataFromUrlCount += 1
        dataFromUrlLastParam = url
        return stubDataFromUrlLastResponse
    }
}
