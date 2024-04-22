//
//  URLSessionAdapter.swift
//  Tuitter
//
//  Created by Joni Bandoni on 21/04/2024.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
    func data(from url: URL) async throws -> (Data, URLResponse)
}

final class URLSessionAdapter {
    private let urlSession: URLSession
    
    init (urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
}

extension URLSessionAdapter: URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await urlSession.data(for: request)
    }
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await urlSession.data(from: url)
    }
    
    
}
