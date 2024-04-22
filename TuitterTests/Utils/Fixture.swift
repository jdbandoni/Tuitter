//
//  Fixture.swift
//  TuitterTests
//
//  Created by Joni Bandoni on 21/04/2024.
//

import Foundation

class Fixture {
    static func jsonDataFromFile(fixturePath: String) -> Data? {
        let relativePath = "Fixtures/\(fixturePath)"
        guard let absoluteUrl = Bundle(for: self).url(forResource: relativePath, withExtension: "json") else {
            return nil
        }
        return try! Data(contentsOf: absoluteUrl)
    }
}
