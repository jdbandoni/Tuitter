//
//  LoginResponseModel.swift
//  Tuitter
//
//  Created by Joni Bandoni on 20/04/2024.
//

import Foundation

// MARK: - LoginResponseModel
struct LoginResponseModel: Codable {
    let accessToken, tokenType: String
    let expiresIn: Int
    let username, profileName: String
    let profilePic: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case username, profileName, profilePic
    }
}
