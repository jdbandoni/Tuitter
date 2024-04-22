//
//  LoginViewModelTests.swift
//  TuitterTests
//
//  Created by Joni Bandoni on 21/04/2024.
//

import XCTest
@testable import Tuitter
import Combine

final class LoginViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    var viewModel: LoginViewModel!
    var mockURLSession: MockURLSession!
    var mockAuthorization: Authorization!

    override func setUpWithError() throws {
        mockAuthorization = Authorization()
        mockURLSession = MockURLSession()
        viewModel = LoginViewModel(urlSession: mockURLSession, authorization: mockAuthorization)
    }

    override func tearDownWithError() throws {
        mockAuthorization = nil
        mockURLSession = nil
        viewModel = nil
        cancellables.removeAll()
    }

    func test_login_whenGranted_shouldSetAuthorization() async {
        //Given
        guard let data = MockData.Login.granted else {
            XCTFail("Failed when getting the mock response for Login")
            return
        }
        let response: URLResponse = HTTPURLResponse(url: URL(string: "https://foo.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        mockURLSession.stubDataFromUrlLastResponse = (data,response)
        
        //when
        await viewModel.login()
        
        //then
        XCTAssertEqual(mockAuthorization.accessToken, "MC4wODJkZW1vLTE3MTM3MzI1NDMwMDE=")
        XCTAssertEqual(mockAuthorization.tokenType, "Bearer")
    }

    func test_login_whenError_shouldNotSetAuthorization() async {
        //Given
        guard let data = MockData.Login.failed else {
            XCTFail("Failed when getting the mock response for Login")
            return
        }
        let response: URLResponse = HTTPURLResponse(url: URL(string: "https://foo.com")!, statusCode: 403, httpVersion: nil, headerFields: nil)!
        mockURLSession.stubDataFromUrlLastResponse = (data,response)
        
        //when
        await viewModel.login()
        
        //then
        XCTAssertEqual(mockAuthorization.accessToken, "")
        XCTAssertEqual(mockAuthorization.tokenType, "")
    }
    
    func test_isLoading_whenGranted_shouldStartAndFinishLoading() async {
        //Given
        guard let data = MockData.Login.granted else {
            XCTFail("Failed when getting the mock response for Login")
            return
        }
        let response: URLResponse = HTTPURLResponse(url: URL(string: "https://foo.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        mockURLSession.stubDataFromUrlLastResponse = (data,response)
        
        //when
        let isLoadingFalseExpectation = XCTestExpectation(description: "should set isLoading to false")
        let isLoadingTrueExpectation = XCTestExpectation(description: "should set isLoading to true")
        var isLoadingValues = [Bool]()
        viewModel.$isLoading
            .dropFirst()
            .sink { isLoading in
                isLoadingValues.append(isLoading)
                if isLoading {
                    isLoadingFalseExpectation.fulfill()
                } else {
                    isLoadingTrueExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        await viewModel.login()
        
        
        //then
        wait(for: [isLoadingFalseExpectation, isLoadingTrueExpectation], timeout: 1)
        XCTAssertEqual(isLoadingValues, [true, false])
    }
    
    func test_isLoading_whenError_shouldStartAndFinishLoading() async {
        //Given
        guard let data = MockData.Login.failed else {
            XCTFail("Failed when getting the mock response for Login")
            return
        }
        let response: URLResponse = HTTPURLResponse(url: URL(string: "https://foo.com")!, statusCode: 403, httpVersion: nil, headerFields: nil)!
        mockURLSession.stubDataFromUrlLastResponse = (data,response)
        
        //when
        let isLoadingFalseExpectation = XCTestExpectation(description: "should set isLoading to false")
        let isLoadingTrueExpectation = XCTestExpectation(description: "should set isLoading to true")
        var isLoadingValues = [Bool]()
        viewModel.$isLoading
            .dropFirst()
            .sink { isLoading in
                isLoadingValues.append(isLoading)
                if isLoading {
                    isLoadingFalseExpectation.fulfill()
                } else {
                    isLoadingTrueExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        await viewModel.login()
        
        
        //then
        wait(for: [isLoadingFalseExpectation, isLoadingTrueExpectation], timeout: 1)
        XCTAssertEqual(isLoadingValues, [true, false])
    }
}
