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
            case .success(let picture):
                XCTAssertNotNil(picture)
                XCTAssertNotNil(picture.date)
                XCTAssertNotNil(picture.explanation)
                XCTAssertNotNil(picture.title)
                XCTAssertNotNil(picture.url)
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

        apiNetworking.fetchRecentPictures { pictures in
            XCTAssertNotNil(pictures)
            XCTAssertNotEqual(pictures.count, 0)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

}
