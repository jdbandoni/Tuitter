//
//  AuthorizationTests.swift
//  TuitterTests
//
//  Created by Joni Bandoni on 21/04/2024.
//

import XCTest
import Combine
@testable import Tuitter

final class AuthorizationTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    var mockAuthorization: Authorization!

    override func setUpWithError() throws {
        mockAuthorization = Authorization()
    }

    override func tearDownWithError() throws {
        mockAuthorization = nil
        cancellables.removeAll()
    }

    func test_isLoggedIn_whenAccessTokenIsSet_shouldPublishChanges() {
        //Given

        //when
        let expectation = XCTestExpectation(description: "should update isLoggedIn variable")
        mockAuthorization.accessToken = "some"
        
        mockAuthorization.$isLoggedIn
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        
        //then
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(mockAuthorization.isLoggedIn)
    }

}
