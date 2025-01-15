//
//  PictureOfTheDayViewModelTests.swift
//  NasaPodProject
//
//  Created by Emmanuel Mathar on 15/01/2025.
//

import XCTest
@testable import NasaPodProject

class PictureOfTheDayViewModelTests: XCTestCase {

    func test_fetchTodayPicture_success() {
        let viewModel = PictureOfTheDayViewModel()
        let mockService = MockApiNetworking()
        mockService.result = .success(PictureOfTheDay(
                                                       copyright : "Author",
                                                       date: "2024-12-31",
                                                       title: "Test Title",
                                                       explanation: "Test explanation",
                                                       url: "https://test.com/image1.jpg",
                                                       mediaType: "media_type"
         ))
        viewModel.service = mockService 
        let expectation = XCTestExpectation(description: "Fetch picture of the day")

        viewModel.fetchTodayPicture()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotNil(viewModel.todayPicture)
            XCTAssertEqual(viewModel.todayPicture?.date, "2024-12-31")
            XCTAssertEqual(viewModel.errorMessage, nil)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func test_fetchTodayPicture_failure() {
        let viewModel = PictureOfTheDayViewModel()
        let mockService = MockApiNetworking()
        mockService.result = .failure(NSError(domain: "Test error", code: 0, userInfo: nil))
        viewModel.service = mockService 
        let expectation = XCTestExpectation(description: "Fetch picture of the day")

        viewModel.fetchTodayPicture()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNil(viewModel.todayPicture)
            XCTAssertNotNil(viewModel.errorMessage)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}

