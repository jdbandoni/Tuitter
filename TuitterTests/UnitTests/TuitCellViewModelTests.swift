//
//  TuitCellViewModelTests.swift
//  TuitterTests
//
//  Created by Joni Bandoni on 21/04/2024.
//

import XCTest
@testable import Tuitter
import Combine

final class TuitCellViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    var viewModel: TuitCellViewModel!
    var mockURLSession: MockURLSession!
    var mockAuthorization: Authorization!

    override func setUpWithError() throws {
        let tuit = Tuit.testSample
        mockAuthorization = Authorization()
        mockURLSession = MockURLSession()
        viewModel = TuitCellViewModel(tuitData: tuit, urlSession: mockURLSession, authorization: mockAuthorization)
    }

    override func tearDownWithError() throws {
        mockAuthorization = nil
        mockURLSession = nil
        viewModel = nil
        cancellables.removeAll()
    }
    
    func test_dateFormatter_shouldHaveCorrectFormat() {
        XCTAssertEqual(viewModel.dateFormatter.dateFormat,"hh:mm a - d MMM yyyy")
    }
    
    func test_creationDate_shouldBeDividedBy1000() {
        XCTAssertEqual(viewModel.creationDate.timeIntervalSince1970, 1687357676.717)
    }
    
    func test_formattedLikes_shouldBeDividedBy1000() {
        XCTAssertEqual(viewModel.formattedLikes, "10")
    }
    
    func test_like_whenIsLiked_shouldSetLiked() async {
        //Given
        guard let data = MockData.Like.ok else {
            XCTFail("Failed when getting the mock response for Login")
            return
        }
        let response: URLResponse = HTTPURLResponse(url: URL(string: "https://foo.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        mockURLSession.stubDataForRequestLastResponse = (data,response)
        mockAuthorization.accessToken = "some"
        mockAuthorization.tokenType = "Bearer"
        
        //when
        await viewModel.like(true)
        
        //then
        XCTAssertEqual(mockURLSession.dataForRequestLastParam?.httpMethod, "POST")
        XCTAssertEqual(mockURLSession.dataForRequestLastParam?.url, URL(string: "https://us-central1-entrevistas-b6aac.cloudfunctions.net/like?ts=1687357676717&like=true"))
        XCTAssertEqual(mockURLSession.dataForRequestLastParam?.allHTTPHeaderFields, ["Authorization" : "Bearer some"])
    }
    
    func test_like_whenIsNotLiked_shouldSetNotLiked() async {
        //Given
        guard let data = MockData.Like.ok else {
            XCTFail("Failed when getting the mock response for Login")
            return
        }
        let response: URLResponse = HTTPURLResponse(url: URL(string: "https://foo.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        mockURLSession.stubDataForRequestLastResponse = (data,response)
        mockAuthorization.accessToken = "some"
        mockAuthorization.tokenType = "Bearer"
        
        //when
        await viewModel.like(false)
        
        //then
        XCTAssertEqual(mockURLSession.dataForRequestLastParam?.httpMethod, "POST")
        XCTAssertEqual(mockURLSession.dataForRequestLastParam?.url, URL(string: "https://us-central1-entrevistas-b6aac.cloudfunctions.net/like?ts=1687357676717&like=false"))
        XCTAssertEqual(mockURLSession.dataForRequestLastParam?.allHTTPHeaderFields, ["Authorization" : "Bearer some"])
    }
    
    func test_like_whenResponseIsOk_shouldUpdateTuit() async {
        //Given
        guard let data = MockData.Like.ok else {
            XCTFail("Failed when getting the mock response for Login")
            return
        }
        let response: URLResponse = HTTPURLResponse(url: URL(string: "https://foo.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        mockURLSession.stubDataForRequestLastResponse = (data,response)
        mockAuthorization.accessToken = "some"
        mockAuthorization.tokenType = "Bearer"
        
        //when
        let expectation = XCTestExpectation(description: "should update tuitData")
        viewModel.$tuitData
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        await viewModel.like(false)
        
        //then
        wait(for: [expectation], timeout: 1)
    }
    
    
    func test_like_whenResponseIsNotOk_shouldNotUpdateTuit() async {
        var wasUpdated = false
        
        //Given
        guard let data = MockData.Like.error else {
            XCTFail("Failed when getting the mock response for Login")
            return
        }
        let response: URLResponse = HTTPURLResponse(url: URL(string: "https://foo.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
        mockURLSession.stubDataForRequestLastResponse = (data,response)
        mockAuthorization.accessToken = "some"
        mockAuthorization.tokenType = "Bearer"
        
        //when
        viewModel.$tuitData
            .dropFirst()
            .sink { _ in
                wasUpdated = true
            }
            .store(in: &cancellables)
        await viewModel.like(false)
        
        //then
        try! await Task.sleep(nanoseconds: UInt64(1 * Double(NSEC_PER_SEC)))
        XCTAssertFalse(wasUpdated)
    }

}
