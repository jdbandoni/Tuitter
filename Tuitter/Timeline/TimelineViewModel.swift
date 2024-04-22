//
//  TimelineViewModel.swift
//  Tuitter
//
//  Created by Joni Bandoni on 20/04/2024.
//

import Foundation
import SwiftUI

final class TimelineViewModel: ObservableObject {
    
    var authorization: Authorization = .shared
    @Published var timeline: TimelineModel = .empty
    
    func getTuits() async {
        guard let url = URL(string: "\(Constants.baseUrl)/posts") else { return }
        
        let request: URLRequest = {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("\(authorization.tokenType) \(authorization.accessToken)", forHTTPHeaderField: "Authorization")
            return request
        }()

        do {
            async let (data, _) = try await URLSession.shared.data(for: request)
            let dataModel = try await JSONDecoder().decode(TimelineModel.self, from: data)
            DispatchQueue.main.async { [weak self] in
                self?.timeline = dataModel
            }
        } catch {
            //do something
        }
    }
    
}
