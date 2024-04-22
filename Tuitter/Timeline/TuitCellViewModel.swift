//
//  TuitCellViewModel.swift
//  Tuitter
//
//  Created by Joni Bandoni on 19/04/2024.
//

import Foundation
import SwiftUI

final class TuitCellViewModel: ObservableObject {
    private var urlSession: URLSessionProtocol
    private var authorization: Authorization = .shared
    
    @Published var tuitData: Tuit
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a - d MMM yyyy"
        return formatter
    }()
    
    var creationDate: Date {
        return Date(timeIntervalSince1970: TimeInterval(tuitData.ts)/1000)
    }
    
    var formattedLikes: String {
        //We could add whatever logic format here
        return "\(tuitData.likes)"
    }
    
    init(tuitData: Tuit = .empty,
         urlSession: URLSessionProtocol = URLSessionAdapter(),
         authorization: Authorization = .shared) {
        self.tuitData = tuitData
        self.urlSession = urlSession
        self.authorization = authorization
    }
}

//MARK: - Async methods
extension TuitCellViewModel {
    func like(_ isLiked: Bool) async {
        guard let url = URL(string: "\(Constants.baseUrl)/like") else { return }
        
        let request: URLRequest = {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("\(authorization.tokenType) \(authorization.accessToken)", forHTTPHeaderField: "Authorization")
            request.url?.append(queryItems: [.init(name: "ts", value: "\(tuitData.ts)")])
            request.url?.append(queryItems: [.init(name: "like", value: "\(isLiked)")])
            return request
        }()

        do {
            async let (data, _) = try await urlSession.data(for: request)
            let dataUpdated = try await JSONDecoder().decode(Tuit.self, from: data)
            DispatchQueue.main.async { [weak self] in
                self?.tuitData = dataUpdated
            }
        } catch {
            //do something
        }
    }
}
