//
//  LoginViewModel.swift
//  Tuitter
//
//  Created by Joni Bandoni on 19/04/2024.
//

import Foundation
import SwiftUI

final class LoginViewModel: ObservableObject {
    private var urlSession: URLSessionProtocol
    private var authorization: Authorization = .shared
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published var isLoading = false
    
    @MainActor
    func login() async {
        guard let url = URL(string: "\(Constants.baseUrl)/login?username=\(username)&password=\(password)") else { return }

        do {
            isLoading = true
            async let (data, _) = try await urlSession.data(from: url)
            let dataModel = try await JSONDecoder().decode(LoginResponseModel.self, from: data)
            isLoading = false
            authorization.accessToken = dataModel.accessToken
            authorization.tokenType = dataModel.tokenType
            authorization.profilePic = dataModel.profilePic
        } catch {
            isLoading = false
            //do something
        }
    }
    
    init (urlSession: URLSessionProtocol = URLSessionAdapter(), authorization: Authorization = .shared) {
        self.urlSession = urlSession
        self.authorization = authorization
    }
}
