//
//  ApiNetworkingTests.swift
//  NasaPodProject
//
//  Created by Emmanuel Mathar on 15/01/2025.
//

import XCTest
@testable import NasaPodProject

class ApiNetworkingTests: XCTestCase {


    func test_getStartDate_returnsDateString30DaysBeforeTodaysDate() {
        let apiNetworking = ApiNetworking.shared
        let expectedDateFormatter = DateFormatter()
        expectedDateFormatter.dateFormat = "yyyy-MM-dd"

        let todaysDate = apiNetworking.getTodaysDate()
        let startDateString = apiNetworking.getStartDate()
        guard let todayDateObject = expectedDateFormatter.date(from: todaysDate) else {
            XCTFail("Error: Invalid todaysDate format")
            return
        }



        let calendar = Calendar.current
        guard let expectedStartDate = calendar.date(byAdding: .day, value: -30, to: todayDateObject) else {
            XCTFail("Error: Could not calculate expectedStartDate")
            return
        }
        let expectedStartDateString = expectedDateFormatter.string(from: expectedStartDate)
        XCTAssertEqual(startDateString, expectedStartDateString)
    }

    func test_fetchPictureOfTheDay_success() {
        let apiNetworking = ApiNetworking.shared
        let expectation = XCTestExpectation(description: "Fetch picture of the day")

        apiNetworking.fetchPictureOfTheDay { result in
            switch result {
            case .success(let pictureData):
                XCTAssertNotNil(pictureData)
                XCTAssertNotNil(pictureData.date)
                XCTAssertNotNil(pictureData.explanation)
                XCTAssertNotNil(pictureData.title)
                XCTAssertNotNil(pictureData.url)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error fetching picture of the day: \(error)")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func test_fetchRecentPictures_success() {
        let apiNetworking = ApiNetworking.shared
        let expectation = XCTestExpectation(description: "Fetch recent pictures")

        apiNetworking.fetchRecentPictures { picturesData in
            XCTAssertNotNil(picturesData)
            XCTAssertNotEqual(picturesData.count, 0)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

}
