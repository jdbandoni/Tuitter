//
//  PostingTuitViewModel.swift
//  Tuitter
//
//  Created by Joni Bandoni on 20/04/2024.
//

import Foundation
import SwiftUI

final class PostingTuitViewModel: ObservableObject {
    
    var authorization: Authorization = .shared
    
    @Published var text: String = ""
    var replyTo: Tuit?
    var title: String {
        replyTo != nil ? "Reply a tuit" : "Post a tuit"
    }
    
    func postTuit() async {
        guard let url = URL(string: "\(Constants.baseUrl)/post") else { return }
        
        let request: URLRequest = {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("\(authorization.tokenType) \(authorization.accessToken)", forHTTPHeaderField: "Authorization")
            request.url?.append(queryItems: [.init(name: "text", value: text)])
            
            if let replyTo = replyTo {
                request.url?.append(queryItems: [.init(name: "replyTo", value: "\(replyTo.ts)"),
                                                 .init(name: "replyToUsername", value: replyTo.username)])
            }
            return request
        }()

        do {
            async let (_, response) = try await URLSession.shared.data(for: request)
            if let response = try await response as? HTTPURLResponse, response.statusCode == 200 {
                DispatchQueue.main.async { [weak self] in
                    self?.text = ""
                }
            }
            
        } catch {
            //do something
        }
    }
    
    init(replyTo: Tuit? = nil) {
        self.replyTo = replyTo
    }
    
}
