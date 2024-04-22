//
//  Data+LoginStub.swift
//  TuitterTests
//
//  Created by Joni Bandoni on 21/04/2024.
//

import Foundation

extension MockData {
    enum Login {
        static let granted = Fixture.jsonDataFromFile(fixturePath: "Login/LoginGranted")
        static let failed = Fixture.jsonDataFromFile(fixturePath: "Login/LoginError")
    }
}
