//
//  LoginResponseModel+Stub.swift
//  TuitterTests
//
//  Created by Joni Bandoni on 21/04/2024.
//

import Foundation
@testable import Tuitter

extension LoginResponseModel {
    static let granted: LoginResponseModel = .init(accessToken: "MC45MzVkZW1vLTE3MTM2NTAzMDMwNDM=",
                                                   tokenType: "Bearer",
                                                   expiresIn: 99999,
                                                   username: "@demo",
                                                   profileName: "Demo",
                                                   profilePic: "https://robohash.org/demo.png")
}
