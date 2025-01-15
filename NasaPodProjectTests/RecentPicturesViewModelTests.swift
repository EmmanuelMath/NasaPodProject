//
//  RecentPicturesViewModelTests.swift
//  NasaPodProject
//
//  Created by Emmanuel Mathar on 15/01/2025.
//

import XCTest
@testable import NasaPodProject

class RecentPicturesViewModelTests: XCTestCase {
    
    func test_fetchRecentPictures_success() {
        let viewModel = RecentPicturesViewModel()
        let mockService = MockApiNetworking()
        mockService.recentPicturesResult = .success([
            PictureOfTheDay(copyright: "Test Title 1",
                            date: "2024-12-31",
                            title: "Test Title 1",
                            explanation: "Test explanation 1",
                            url: "https://test.com/image1.jpg",
                            mediaType: "image"),
            PictureOfTheDay(copyright: "Test Title 2",
                            date: "2024-12-30",
                            title: "Test Title 2",
                            explanation: "Test explanation 2",
                            url: "https://test.com/image2.jpg",
                            mediaType: "image")
        ])
        viewModel.service = mockService
        let expectation = XCTestExpectation(description: "Fetch recent pictures")
        
        viewModel.fetchRecentPictures()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(viewModel.recentPictures.count, 2)
            XCTAssertEqual(viewModel.recentPictures[0].title, "Test Title 1")
            XCTAssertEqual(viewModel.recentPictures[1].title, "Test Title 2")
            XCTAssertEqual(viewModel.errorMessage, nil)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
