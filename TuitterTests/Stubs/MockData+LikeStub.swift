//
//  MockData+LikeStub.swift
//  TuitterTests
//
//  Created by Joni Bandoni on 21/04/2024.
//

import Foundation

extension MockData {
    enum Like {
        static let ok = Fixture.jsonDataFromFile(fixturePath: "Like/LikeOk")
        static let error = Fixture.jsonDataFromFile(fixturePath: "Like/LikeError")
    }
}
